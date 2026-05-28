#!/bin/bash
WALL=$(grep -oP '(?<=^# WALLPAPER=).*' "$HOME/.config/hypr/hyprland.conf")
if [[ -n "$WALL" ]]; then
    hyprctl hyprpaper preload "$WALL"
    hyprctl hyprpaper wallpaper "eDP-1,$WALL"
fi
