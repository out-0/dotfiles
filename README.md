# Dotfiles

Personal configuration files for Arch Linux with Hyprland.

## Features

- **Quickshell Widgets**: QML-based launcher, music widget, wallpaper picker, and workspace overview for Hyprland
  - Launcher panel: `Super + Space` (requires mouse hover before typing)
  - Music panel: `Super + M` (Spotify integration with album art)
  - Wallpaper picker: `Super + Ctrl + W` (Unit-3 style carousel picker)
  - Workspace overview: `Super + Tab` (Exposé-style grid with live window previews)
  - Language switch: `Alt + Space`
- **Hyprland Window Manager**: Tiling window manager with custom keybindings
  - White border colors for active/inactive windows
  - Fixed reversed scrolling for mouse and touchpad
  - Comprehensive decoration settings (blur, shadows, rounding)
- **Spotify Integration**: Music widget displays current track with controls
- **LibreWolf**: Minimal browser UI with userChrome customization
- **Catppuccin Theme**: Consistent pastel theme across Spotify, Rofi, and btop
- **System Tools**: btop (monitor), Cava (audio visualizer), fastfetch (system info)

## Installation

### Prerequisites

Install required packages:
```bash
# Core dependencies
yay -S quickshell playerctl ncspot awww

# System tools
yay -S btop cava fastfetch

# Theme customization
yay -S spicetify-cli btop-theme-catppuccin

# Browser
yay -S librewolf spotify
```

### Setup

1. Clone the repository:
```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
```

2. Run the setup script:
```bash
./setupMe
```

3. Configure wallpaper path in `~/.config/quickshell/shell.qml`:
   - Change `wallpaperPath` to your wallpaper directory
   - Default: `~/Downloads/wallpapers`

4. Add Quickshell to autostart (already configured in `~/.config/hypr/config/autostart.conf`)

5. Configure Spotify with Catppuccin theme:
```bash
# Install Spicetify
yay -S spicetify-cli

# Clone Catppuccin theme
git clone --depth=1 https://github.com/catppuccin/spicetify.git /tmp/catppuccin-spicetify
cp -r /tmp/catppuccin-spicetify ~/.config/spicetify/Themes/Catppuccin

# Configure and apply
spicetify config current_theme Catppuccin/catppuccin
spicetify config color_scheme mocha
spicetify backup apply
```

6. Configure Rofi with Catppuccin theme:
```bash
# Clone theme
git clone --depth=1 https://github.com/catppuccin/rofi.git /tmp/catppuccin-rofi
cp /tmp/catppuccin-rofi/catppuccin-default.rasi ~/.config/rofi/
cp /tmp/catppuccin-rofi/themes/catppuccin-mocha.rasi ~/.config/rofi/

# Update config to use theme (already configured in ~/.config/rofi/config.rasi)
```

7. Configure btop with Catppuccin theme and transparency:
```bash
# Theme is installed via btop-theme-catppuccin package
# Config already set in ~/.config/btop/btop.conf
```

8. Configure LibreWolf minimal UI:
```bash
# userChrome.css already created at ~/.librewolf/*/chrome/userChrome.css
# Enable in LibreWolf: about:config -> toolkit.legacyUserProfileCustomizations.stylesheets = true
```

9. Reload Hyprland:
```bash
hyprctl reload
```

## Quickshell Configuration

### Launcher Panel
- Opens with `Super + Space`
- Shows applications and wallpapers
- **Note**: Requires mouse hover before keyboard input works (Quickshell OnDemand mode limitation)

### Music Panel
- Opens with `Super + M`
- Displays Spotify track info with album art
- Controls: Play/Pause, Next, Previous
- Positioned at top center of screen

### Wallpaper Picker
- Opens with `Super + Ctrl + W`
- Unit-3 style carousel picker with NieR:Automata theme
- Navigate with arrow keys, scroll wheel, or click
- Apply wallpaper to current screen or all screens
- Uses `awww img` for wallpaper management
- Wallpapers stored in `~/Pictures/Wallpapers`

### Workspace Overview
- Opens with `Super + Tab`
- Exposé-style grid showing all workspaces with live window previews
- Click windows to focus them
- Middle-click windows to close them
- Drag and drop windows between workspaces
- Keyboard navigation (arrow keys, vim keys, number shortcuts)
- Auto-closes on focus loss or outside click
- Material Design 3 theming

### Keybindings
- `Super + Space`: Toggle launcher
- `Super + M`: Toggle music panel
- `Super + Ctrl + W`: Toggle wallpaper picker
- `Super + Tab`: Toggle workspace overview
- `Super + O`: Open LibreWolf
- `Super + S`: Open Spotify
- `Alt + Space`: Switch keyboard layout
- `Super + R`: Rofi launcher (Catppuccin themed)

## System Tools

### btop
- System resource monitor with Catppuccin mocha theme
- Transparent background
- Launch: `btop`
- Config: `~/.config/btop/btop.conf`

### Cava
- Audio visualizer for terminal
- Launch: `cava` (requires audio playing)
- Controls: Up/Down (sensitivity), Left/Right (bars), r (reload), q (quit)

### fastfetch
- System information display
- Launch: `fastfetch`
- Config: `~/.config/fastfetch/config.conf`

## Theme Configuration

### Catppuccin Theme
Consistent pastel theme across multiple applications:
- **Spotify**: Mocha flavor via Spicetify
- **Rofi**: Mocha flavor
- **btop**: Mocha flavor with transparency

### LibreWolf Minimal UI
- Hides URL bar, toolbar, and tab bar
- Clean content-only view
- Configured via `~/.librewolf/*/chrome/userChrome.css`
- Enable: `about:config` → `toolkit.legacyUserProfileCustomizations.stylesheets = true`

## Customization

### Wallpaper Directory
Edit `~/.config/quickshell/shell.qml`:
```qml
property string wallpaperPath: homePath + "/path/to/your/wallpapers"
```

### Window Rules
Edit `~/.config/hypr/config/windowrules.conf` to customize window behavior.

### Keybindings
Edit `~/.config/hypr/config/keybindings.conf` to customize keybindings.

## Troubleshooting

### Quickshell not loading
- Check config syntax: `quickshell check`
- View logs: `quickshell list` then check log path

### Music widget not showing Spotify info
- Ensure Spotify is running
- Check playerctl: `playerctl -l` should show `spotify`
- Verify playerctl metadata: `playerctl metadata --player spotify`

### Launcher keyboard focus
- The launcher requires mouse hover before typing (Quickshell limitation)
- This is due to `WlrKeyboardFocus.OnDemand` mode which allows mouse interaction
