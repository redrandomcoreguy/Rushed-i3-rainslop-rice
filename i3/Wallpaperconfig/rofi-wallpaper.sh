#!/bin/bash

WALL_DIR="$HOME/.config/i3/Wallpaperconfig/Wallpapers"
SELECTION=$(ls -1 "$WALL_DIR" | rofi -dmenu -i -p "Wallpaper:")

if [ -n "$SELECTION" ]; then
    feh --bg-fill "$WALL_DIR/$SELECTION"
fi
