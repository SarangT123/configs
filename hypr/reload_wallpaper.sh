#!/bin/bash
WALL=$(grep -oP '(?<=^# WALLPAPER=).*' "$HOME/.config/hypr/hyprland.conf")
if [[ -n "$WALL" ]]; then
    pkill swaybg 2>/dev/null
    swaybg -i "$WALL" -m fill &
    disown
fi
