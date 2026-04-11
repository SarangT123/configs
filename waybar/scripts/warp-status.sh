#!/bin/bash

# Check if warp-cli is installed
if ! command -v warp-cli &> /dev/null; then
    echo '{"text": "🔒 WARP N/A", "tooltip": "Cloudflare WARP is not installed", "class": "disconnected"}'
    exit 0
fi

# Get WARP status
STATUS=$(warp-cli status 2>/dev/null | grep -i "status" | awk '{print $NF}')

case "$STATUS" in
    "Connected")
        echo '{"text": "🔒 WARP", "tooltip": "Cloudflare WARP: Connected\nClick to disconnect", "class": "connected"}'
        ;;
    "Disconnected")
        echo '{"text": "🔓 WARP", "tooltip": "Cloudflare WARP: Disconnected\nClick to connect", "class": "disconnected"}'
        ;;
    "Connecting")
        echo '{"text": "🔄 WARP", "tooltip": "Cloudflare WARP: Connecting...", "class": "connecting"}'
        ;;
    *)
        echo '{"text": "❓ WARP", "tooltip": "Cloudflare WARP: Unknown status", "class": "unknown"}'
        ;;
esac
