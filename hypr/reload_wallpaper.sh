#!/bin/bash
WALL=$(grep -oP '(?<=^# WALLPAPER=).*' "$HOME/.config/hypr/hyprland.conf")
[[ -n "$WALL" ]] && hyprctl hyprpaper wallpaper "eDP-1,$WALL"
