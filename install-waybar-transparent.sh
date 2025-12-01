#!/bin/bash

set -e

WAYBAR_CSS="$HOME/.config/waybar/style.css"
MARKER="/* OMARCHY-SUPPLEMENT-TRANSPARENCY */"

# Check if file exists
if [ ! -f "$WAYBAR_CSS" ]; then
    echo "⚠️  Waybar CSS not found at $WAYBAR_CSS"
    exit 0
fi

# Check if we already applied the fix
if grep -Fq "$MARKER" "$WAYBAR_CSS"; then
    echo "⏩ Skipped: Waybar transparency already applied."
else
    echo "🎨 Applying transparency to Waybar..."
    
    # Append the CSS override to the bottom of the file
    cat <<EOT >> "$WAYBAR_CSS"

$MARKER
* {
    background-color: rgba(0, 0, 0, 0.0);
}
EOT
    echo "✅ Waybar CSS updated."
fi
