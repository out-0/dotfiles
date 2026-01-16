#!/bin/bash

WALLPAPER_DIR="$HOME/.config/Wallpapers/"

# Start swww-daemon if it's not running
pgrep -x swww-daemon > /dev/null || swww-daemon &

# Small delay to make sure daemon is ready
sleep 0.3

# Let user pick wallpaper
SELECTED=$(ls "$WALLPAPER_DIR" | rofi -dmenu -p "Choose wallpaper")
[ -z "$SELECTED" ] && exit

# Set the selected wallpaper
swww img "$WALLPAPER_DIR/$SELECTED" --transition-type any --transition-duration 0.5 --transition-fps 60
