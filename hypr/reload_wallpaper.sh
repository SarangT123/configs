#!/bin/bash
WALL_DIR="$HOME/Pictures/wallpapers"
WALL=$(find "$WALL_DIR" -maxdepth 1 -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.webp' \) | shuf -n1)
if [[ -n "$WALL" ]]; then
    pkill swaybg 2>/dev/null
    swaybg -i "$WALL" -m fill &
    disown
    notify-send "Wallpaper" "Changed to $(basename "$WALL")"
else
    notify-send -u critical "Wallpaper" "No images found in $WALL_DIR"
fi
