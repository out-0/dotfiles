import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "./components"

ShellRoot {
    id: root

    IpcHandler {
        id: ipc
        target: "shell"
        function toggleLauncher() { root.toggleLauncher() }
        function toggleMusic() { root.toggleMusic() }
        function closeAll() { root.closeAllPanels() }
    }

    property string configPath: Quickshell.env("HOME") + "/.config/quickshell"
    property string homePath: Quickshell.env("HOME")
    // Customize this path to your wallpaper directory
    // Common locations: ~/Pictures/Wallpapers, ~/Downloads/wallpapers, ~/Wallpapers
    property string wallpaperPath: homePath + "/Pictures/Wallpapers"
    property string cachePath: homePath + "/.cache/quickshell"
    property string statePath: configPath + "/state"

    property bool launcherVisible: false
    property bool musicVisible: false

    property var appList: []
    property var appUsage: ({})
    property string searchTerm: ""
    property var filteredApps: {
        var source = appList
        var usage = appUsage
        if (searchTerm !== "") {
            var result = []
            for (var i = 0; i < source.length; i++) {
                var entry = source[i]
                if (entry.name.toLowerCase().includes(searchTerm) || entry.exec.toLowerCase().includes(searchTerm)) {
                    result.push(entry)
                }
            }
            source = result
        }
        var sorted = source.slice().sort(function(a, b) {
            var countA = usage[a.name] || 0
            var countB = usage[b.name] || 0
            if (countB !== countA) return countB - countA
            return a.name.localeCompare(b.name)
        })
        return sorted
    }
    property int selectedIndex: 0
    property int activeTab: 0

    property string wallSearchTerm: ""
    property var wallpaperList: []
    property var filteredWallpapers: {
        if (wallSearchTerm === "") return wallpaperList
        var result = []
        for (var i = 0; i < wallpaperList.length; i++) {
            if (wallpaperList[i].name.toLowerCase().includes(wallSearchTerm)) {
                result.push(wallpaperList[i])
            }
        }
        return result
    }
    property int wallSelectedIndex: 0
    property string currentWallpaper: ""
    property bool wallsLoaded: false

    property color walBackground: "#1e1e2e"
    property color walForeground: "#cdd6f4"
    property color walColor5: "#89b4fa"
    property color walColor8: "#6c7086"
    property color walColor13: "#f5c2e7"

    property var focusedScreen: Quickshell.screens[0]

    function toggleLauncher() { launcherVisible = !launcherVisible }
    function toggleMusic() { musicVisible = !musicVisible }
    function closeAllPanels() {
        launcherVisible = false
        musicVisible = false
    }

    function launchApp(app) {
        var cmd = app.exec
        launchProc.command = ["bash", "-c", "nohup " + cmd + " >/dev/null 2>&1 & disown"]
        launchProc.running = true
        var usage = appUsage
        var updated = {}
        for (var key in usage) updated[key] = usage[key]
        updated[app.name] = (updated[app.name] || 0) + 1
        appUsage = updated
        saveUsageProc.command = ["bash", "-c", "echo '" + JSON.stringify(updated) + "' > '" + root.configPath + "/app_usage.json'"]
        saveUsageProc.running = true
        root.launcherVisible = false
    }

    function applyWallpaper(wallpaper) {
        root.currentWallpaper = wallpaper.path
        applyWallProc.command = ["bash", "-c",
            "ln -sf '" + wallpaper.path + "' '" + root.wallpaperPath + "/current' && " +
            "swww img '" + wallpaper.path + "' --transition-type any --transition-duration 2"
        ]
        applyWallProc.running = true
    }

    function loadWallpapers() {
        root.wallpaperList = []
        root.wallsLoaded = false
        if (!wallpaperListProc.running) wallpaperListProc.running = true
    }

    Component.onCompleted: {
        initStateDir.running = true
    }

    Process {
        id: initStateDir
        command: ["mkdir", "-p", root.statePath]
        onExited: {
            appListProc.running = true
            loadUsageProc.running = true
            currentWallProc.running = true
            loadWallpapers()
        }
    }

    Process { id: saveUsageProc }
    Process { id: launchProc }
    Process { id: applyWallProc }

    Process {
        id: loadUsageProc
        command: ["bash", "-c", "cat '" + root.configPath + "/app_usage.json' 2>/dev/null || echo '{}'"]
        stdout: SplitParser {
            splitMarker: ""
            onRead: data => {
                try { root.appUsage = JSON.parse(data.trim()) } catch(e) { root.appUsage = {} }
            }
        }
    }

    Process {
        id: currentWallProc
        command: ["bash", "-c", "readlink -f '" + root.wallpaperPath + "/current' 2>/dev/null || echo ''"]
        stdout: SplitParser { onRead: data => root.currentWallpaper = data.trim() }
    }

    Process {
        id: focusedMonProc
        command: ["bash", "-c", "hyprctl activeworkspace -j | jq -r '.monitor'"]
        stdout: SplitParser {
            onRead: data => {
                var monName = data.trim()
                for (var i = 0; i < Quickshell.screens.length; i++) {
                    if (Quickshell.screens[i].name === monName) {
                        root.focusedScreen = Quickshell.screens[i]
                        break
                    }
                }
            }
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if (!focusedMonProc.running) focusedMonProc.running = true
        }
    }

    Process {
        id: appListProc
        command: ["bash", "-c",
            "dirs=(\"/usr/share/applications\" \"$HOME/.local/share/applications\"); " +
            "for dir in \"${dirs[@]}\"; do " +
            "  for f in \"$dir\"/*.desktop; do " +
            "    [ -f \"$f\" ] || continue; " +
            "    grep -qi '^NoDisplay=true' \"$f\" && continue; " +
            "    grep -qi '^Hidden=true' \"$f\" && continue; " +
            "    name=$(grep -m1 '^Name=' \"$f\" | cut -d= -f2-); " +
            "    exec=$(grep -m1 '^Exec=' \"$f\" | cut -d= -f2- | sed 's/ %[fFuUdDnNickvm]//g'); " +
            "    icon=$(grep -m1 '^Icon=' \"$f\" | cut -d= -f2-); " +
            "    [ -z \"$name\" ] && continue; " +
            "    [ -z \"$exec\" ] && continue; " +
            "    printf '%s\\t%s\\t%s\\n' \"$name\" \"$exec\" \"$icon\"; " +
            "  done; " +
            "done | sort -f -t$'\\t' -k1,1 | awk -F'\\t' '!seen[$1]++'"
        ]
        stdout: SplitParser {
            onRead: data => {
                var line = data.trim()
                if (line.length === 0) return
                var parts = line.split("\t")
                if (parts.length < 2) return
                var current = root.appList.slice()
                current.push({ name: parts[0], exec: parts[1], icon: parts.length > 2 ? parts[2] : "" })
                root.appList = current
            }
        }
    }

    Process {
        id: wallpaperListProc
        command: ["bash", "-c", "find '" + root.wallpaperPath + "' -maxdepth 1 -type f \\( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \\) ! -name '.*' 2>/dev/null | sort"]
        stdout: SplitParser {
            onRead: data => {
                var path = data.trim()
                if (path.length === 0) return
                var parts = path.split("/")
                var name = parts[parts.length - 1]
                var current = root.wallpaperList.slice()
                current.push({ name: name, path: path })
                root.wallpaperList = current
            }
        }
        onExited: {
            root.wallsLoaded = true
        }
    }

    LauncherPanel {}
    MusicPanel {}
}
