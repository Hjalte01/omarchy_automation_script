#!/bin/bash

# Paths
CONF_DIR="$HOME/omarchy-supplement/config/keyd_variants"
TARGET="/etc/keyd/default.conf"

# Check if we are currently using the MAC config
# (We check for the unique "leftalt = leftmeta" line)
if grep -q "leftalt = leftmeta" "$TARGET"; then
    echo "Switching to WINDOWS Mode..."
    cp "$CONF_DIR/win.conf" "$TARGET"
    notify-send "Keyboard" "Switched to WINDOWS Hardware Mode"
else
    echo "Switching to MAC Mode..."
    cp "$CONF_DIR/mac.conf" "$TARGET"
    notify-send "Keyboard" "Switched to MAC Hardware Mode"
fi

# Restart Keyd (No password needed due to Step 2)
sudo systemctl restart keyd
