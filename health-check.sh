#!/bin/bash

echo "------------------------------------------------"
echo "🔍 Checking Configuration Health..."

# Force a reload
hyprctl reload

# Grep the log for config errors
# We look at the last 50 lines of the log immediately after reload
LOG_FILE="$XDG_RUNTIME_DIR/hypr/$(ls -t $XDG_RUNTIME_DIR/hypr/ | head -n 1)/hyprland.log"

if grep -i "config error" "$LOG_FILE" | tail -n 5; then
    echo "❌ WARNING: Config errors detected!"
    echo "Check the red bar on top of your screen or run: cat $LOG_FILE"
else
    echo "✅ Configuration looks clean. No errors found."
fi
echo "------------------------------------------------"
