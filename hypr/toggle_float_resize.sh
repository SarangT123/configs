#!/bin/bash
hyprctl dispatch togglefloating
sleep 0.05
is_float=$(hyprctl activewindow -j | jq '.floating')
if [ "$is_float" = "true" ]; then
    hyprctl dispatch resizeactive exact 60% 60%
    hyprctl dispatch centerwindow
fi
