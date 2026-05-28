#!/bin/bash
WALL=$(grep -oP '(?<=swaybg -i )\S+' "$HOME/.config/hypr/hyprland.conf")
if [[ -n "$WALL" ]]; then
    OLD_PID=$(pgrep -x swaybg)
    swaybg -i "$WALL" -m fill &
    disown
    sleep 0.2
    [[ -n "$OLD_PID" ]] && kill "$OLD_PID" 2>/dev/null
fi
