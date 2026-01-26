#!/bin/bash

# Define paths
WP_DIR="$HOME/dotfiles/Wallpapers"
THEME_FILE="$HOME/dotfiles/kitty_themes.txt"

if [ -f "$THEME_FILE" ]; then
    # 1. Pick a random theme
    CHOSEN_THEME=$(shuf -n 1 "$THEME_FILE")
    echo "$CHOSEN_THEME" > ~/.config/kitty/current_theme_name.txt
    

    # 3. Match Wallpaper to Theme
    case "$CHOSEN_THEME" in
        "Cyberpunk Neon")    WALLPAPER="Cyberpunk_Neon.jpg" ;;
        "Cyberpunk")         WALLPAPER="Cyberpunk.jpg" ;;
        "Pastel Cyberpunk")  WALLPAPER="Pastel_Cyberpunk.png" ;;
        "Sakura Night")      WALLPAPER="Sakura_Night.jpg" ;;
        "Duotone Dark")      WALLPAPER="Duotone_Dark.jpg" ;;
        "1984 Dark")         WALLPAPER="shinobo.png" ;;
        "shadotheme")        WALLPAPER="shadotheme.png" ;;
        "Tropical Neon")     WALLPAPER="Tropical_Neon.jpg" ;;
        "Jackie Brown")      WALLPAPER="Jackie_Brown.jpeg" ;;
        *)                   WALLPAPER="c2.jpeg" ;;
    esac

    WP_PATH="$WP_DIR/$WALLPAPER"

# 4. Apply to Hyprland Wallpaper (Silent & Instant)
    if [ -f "$WP_PATH" ]; then
        {
            # Start daemon if not running, silence output
            pgrep swww-daemon > /dev/null || swww-daemon > /dev/null 2>&1 &
            
            # Initialize swww if needed, silence output
            swww query > /dev/null 2>&1 || swww init > /dev/null 2>&1
            
            # Change wallpaper instantly, silence output
            swww img "$WP_PATH"  > /dev/null 2>&1
        } & 
    fi
    # 2. Apply Kitty Theme
    kitten themes --reload-in=all "$CHOSEN_THEME"

    # 5. Optional: Update Hyprlock (if you use it)
    # Most people point hyprlock.conf to a symlink.
    ln -sf "$WP_PATH" ~/.config/hypr/current_wallpaper.png
fi
