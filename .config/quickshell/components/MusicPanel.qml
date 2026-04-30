import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

PanelWindow {
    id: musicPanel
    screen: root.focusedScreen ?? Quickshell.screens[0]
    visible: root.musicVisible
    exclusionMode: ExclusionMode.Ignore
    anchors { top: true; left: true }
    margins { top: 50; left: (musicPanel.screen ? (musicPanel.screen.width - 400) / 2 : 0) }
    implicitWidth: 400
    implicitHeight: 180
    color: "transparent"
    focusable: true
    WlrLayershell.keyboardFocus: root.musicVisible ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

    property string configPath: root.configPath
    property string playerStatus: "Stopped"
    property string trackTitle: ""
    property string trackArtist: ""
    property real position: 0
    property real length: 0
    property bool hasTrack: playerStatus === "Playing" || playerStatus === "Paused"
    property string coverArtUrl: ""

    function formatTime(seconds) {
        var mins = Math.floor(seconds / 60)
        var secs = Math.floor(seconds % 60)
        return mins + ":" + (secs < 10 ? "0" : "") + secs
    }

    function refreshMetadata() {
        if (!metadataProc.running) metadataProc.running = true
        if (!statusProc.running) statusProc.running = true
        if (!positionProc.running) positionProc.running = true
        if (!coverProc.running) coverProc.running = true
    }

    Timer {
        id: refreshTimer
        interval: 1000
        running: root.musicVisible
        repeat: true
        triggeredOnStart: true
        onTriggered: musicPanel.refreshMetadata()
    }

    Process {
        id: metadataProc
        command: ["bash", "-c", "playerctl --player spotify metadata --format '{{xesam:title}}|{{xesam:artist}}' 2>/dev/null || echo ''"]
        stdout: SplitParser {
            onRead: data => {
                var line = data.trim()
                if (line.length === 0) {
                    musicPanel.trackTitle = ""
                    musicPanel.trackArtist = ""
                    return
                }
                var parts = line.split("|")
                if (parts.length >= 2) {
                    musicPanel.trackTitle = parts[0]
                    musicPanel.trackArtist = parts[1]
                }
            }
        }
    }

    Process {
        id: statusProc
        command: ["bash", "-c", "playerctl --player spotify status 2>/dev/null || echo 'Stopped'"]
        stdout: SplitParser {
            onRead: data => musicPanel.playerStatus = data.trim()
        }
    }

    Process {
        id: positionProc
        command: ["bash", "-c", "playerctl --player spotify position 2>/dev/null || echo '0'"]
        stdout: SplitParser {
            onRead: data => musicPanel.position = parseFloat(data.trim()) || 0
        }
    }

    Process {
        id: lengthProc
        command: ["bash", "-c", "playerctl --player spotify metadata mpris:length 2>/dev/null || echo '0'"]
        stdout: SplitParser {
            onRead: data => {
                var len = parseFloat(data.trim()) || 0
                musicPanel.length = len / 1000000
            }
        }
    }

    Process {
        id: coverProc
        command: ["bash", "-c", "playerctl --player spotify metadata mpris:artUrl 2>/dev/null || echo ''"]
        stdout: SplitParser {
            onRead: data => musicPanel.coverArtUrl = data.trim()
        }
    }

    Process {
        id: playPauseProc
        command: ["playerctl", "--player", "spotify", "play-pause"]
    }

    Process {
        id: nextProc
        command: ["playerctl", "--player", "spotify", "next"]
    }

    Process {
        id: prevProc
        command: ["playerctl", "--player", "spotify", "previous"]
    }

    Item {
        anchors.fill: parent
        focus: root.musicVisible

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Escape) {
                root.musicVisible = false
                event.accepted = true
            } else if (event.key === Qt.Key_Space) {
                if (!playPauseProc.running) playPauseProc.running = true
                event.accepted = true
            } else if (event.key === Qt.Key_N) {
                if (!nextProc.running) nextProc.running = true
                event.accepted = true
            } else if (event.key === Qt.Key_P) {
                if (!prevProc.running) prevProc.running = true
                event.accepted = true
            }
        }

        Rectangle {
            width: 400
            height: 180
            color: Qt.rgba(root.walBackground.r, root.walBackground.g, root.walBackground.b, 0.95)
            radius: 15
            clip: true


            RowLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 15

                Rectangle {
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 150
                    radius: 12
                    color: Qt.rgba(0, 0, 0, 0.3)
                    Image {
                        anchors.fill: parent
                        anchors.margins: 4
                        source: musicPanel.coverArtUrl || ""
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        cache: true
                        visible: musicPanel.coverArtUrl !== ""
                    }
                    Text {
                        anchors.centerIn: parent
                        visible: musicPanel.coverArtUrl === ""
                        text: "󰝚"
                        color: root.walColor8
                        font.pixelSize: 48
                        font.family: "JetBrainsMono Nerd Font"
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 8

                    Text {
                        text: musicPanel.trackTitle || "Nothing is playing"
                        color: root.walColor5
                        font.pixelSize: 15
                        font.bold: true
                        font.family: "JetBrainsMono Nerd Font"
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                    }

                    Text {
                        text: musicPanel.trackArtist || ""
                        color: root.walForeground
                        font.pixelSize: 12
                        font.family: "JetBrainsMono Nerd Font"
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                        visible: musicPanel.trackArtist !== ""
                        opacity: 0.8
                    }

                    Item { Layout.fillHeight: true }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 4
                        radius: 2
                        color: Qt.rgba(0, 0, 0, 0.5)

                        Rectangle {
                            width: musicPanel.length > 0 ? parent.width * (musicPanel.position / musicPanel.length) : 0
                            height: parent.height
                            radius: 2
                            color: root.walColor5
                        }
                    }

                    Row {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 12
                        opacity: musicPanel.hasTrack ? 1.0 : 0.5

                        Rectangle {
                            width: 32
                            height: 32
                            radius: 8
                            color: prevMa.containsMouse ? Qt.rgba(1,1,1,0.1) : "transparent"

                            Text {
                                anchors.centerIn: parent
                                text: "󰒮"
                                color: root.walForeground
                                font.pixelSize: 16
                                font.family: "JetBrainsMono Nerd Font"
                            }

                            MouseArea {
                                id: prevMa
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: if (!prevProc.running) prevProc.running = true
                            }
                        }

                        Rectangle {
                            width: 40
                            height: 40
                            radius: 20
                            color: root.walColor5

                            Text {
                                anchors.centerIn: parent
                                text: musicPanel.playerStatus === "Playing" ? "󰏤" : "󰐊"
                                color: root.walBackground
                                font.pixelSize: 18
                                font.family: "JetBrainsMono Nerd Font"
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: if (!playPauseProc.running) playPauseProc.running = true
                            }
                        }

                        Rectangle {
                            width: 32
                            height: 32
                            radius: 8
                            color: nextMa.containsMouse ? Qt.rgba(1,1,1,0.1) : "transparent"

                            Text {
                                anchors.centerIn: parent
                                text: "󰒭"
                                color: root.walForeground
                                font.pixelSize: 16
                                font.family: "JetBrainsMono Nerd Font"
                            }

                            MouseArea {
                                id: nextMa
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: if (!nextProc.running) nextProc.running = true
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        lengthProc.running = true
    }
}
