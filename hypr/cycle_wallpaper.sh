#!/bin/bash
CONFIG="$HOME/.config/hypr/hyprland.conf"
HPAPER="$HOME/.config/hypr/hyprpaper.conf"
WALL_DIR="$HOME/Pictures/wallpapers"

CURRENT=$(grep -oP '(?<=^# WALLPAPER=).*' "$CONFIG")
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

sed -i "s|^# WALLPAPER=.*|# WALLPAPER=$NEXT|" "$CONFIG"
echo -e "preload = $NEXT\nwallpaper = eDP-1,$NEXT" > "$HPAPER"

hyprctl hyprpaper wallpaper "eDP-1,$NEXT"
notify-send "Wallpaper" "$(basename "$NEXT")"
