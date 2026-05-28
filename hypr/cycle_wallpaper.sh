#!/bin/bash
CONFIG="$HOME/.config/hypr/hyprland.conf"
WALL_DIR="$HOME/Pictures/wallpapers"

CURRENT=$(grep -oP '(?<=swaybg -i )\S+' "$CONFIG")
WALLS=($(find "$WALL_DIR" -maxdepth 1 -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.webp' \) | sort))

if [[ ${#WALLS[@]} -eq 0 ]]; then
    notify-send -u critical "Wallpaper" "No images found"
    exit 1
fi

NEXT="${WALLS[0]}"
for i in "${!WALLS[@]}"; do
    if [[ "${WALLS[$i]}" == "$CURRENT" ]]; then
        NEXT="${WALLS[$(( (i + 1) % ${#WALLS[@]} ))]}"
        break
    fi
done

sed -i "s|swaybg -i .* -m fill|swaybg -i $NEXT -m fill|" "$CONFIG"

OLD_PID=$(pgrep -x swaybg)
swaybg -i "$NEXT" -m fill &
disown
sleep 0.2
[[ -n "$OLD_PID" ]] && kill "$OLD_PID" 2>/dev/null

notify-send "Wallpaper" "$(basename "$NEXT")"
