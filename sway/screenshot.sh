#!/bin/bash

FILE=~/Pictures/screenshot-$(date +%Y%m%d_%H%M%S).png

# 1. Use the ABSOLUTE path so Sway cannot fail to find it
~/.cargo/bin/wayfreeze &
PID=$!

# 2. Give it a split second to draw
sleep 0.2

# 3. Take the screenshot
case $1 in
    "full")
        grim "$FILE"
        ;;
    "area")
        grim -g "$(slurp)" "$FILE"
        ;;
    "copy-full")
        grim - | wl-copy
        ;;
    "copy-area")
        grim -g "$(slurp)" - | wl-copy
        ;;
esac

# 4. Unfreeze
kill $PID