#!/bin/bash

# Check if warp-cli is installed
if ! command -v warp-cli &> /dev/null; then
    notify-send "Cloudflare WARP" "warp-cli is not installed" -u critical
    exit 1
fi

# Get current status
STATUS=$(warp-cli status 2>/dev/null | grep -i "status" | awk '{print $NF}')

case "$STATUS" in
    "Connected")
        warp-cli disconnect
        notify-send "Cloudflare WARP" "Disconnecting..." -t 2000
        ;;
    "Disconnected")
        warp-cli connect
        notify-send "Cloudflare WARP" "Connecting..." -t 2000
        ;;
    *)
        notify-send "Cloudflare WARP" "Unknown status. Please check manually." -u critical
        ;;
esac
