#!/bin/bash

# Stop immediately if a command fails
set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_SRC="$SCRIPT_DIR/bin"
BIN_DEST="$HOME/.local/bin"

echo "------------------------------------------------"
echo "🔧 Setting up custom scripts..."

# 1. Create Destination
if [ ! -d "$BIN_DEST" ]; then
    echo "Creating directory: $BIN_DEST"
    mkdir -p "$BIN_DEST"
fi

# 2. Define the specific script map
# Format: "SourceFile.sh:LinkName"
SCRIPTS=(
    "omarchy-launch-webapp.sh:omarchy-launch-webapp"
    # Add future scripts here like: "my-backup.sh:backup-system"
)

# 3. Loop through and link
for pair in "${SCRIPTS[@]}"; do
    # Split the string into Source and Link Name
    SRC_FILE="${pair%%:*}"
    LINK_NAME="${pair##*:}"
    
    FULL_SRC="$BIN_SRC/$SRC_FILE"
    FULL_DEST="$BIN_DEST/$LINK_NAME"

    # Check if source exists
    if [ ! -f "$FULL_SRC" ]; then
        echo "❌ ERROR: Source script not found: $FULL_SRC"
        exit 1
    fi


    # Ensure executable
    chmod +x "$FULL_SRC"

    # Check if destination exists (-e) AND is a symlink (-L)
    if [ -L "$FULL_DEST" ] && [ -e "$FULL_DEST" ]; then 
        CURRENT_TARGET=$(readlink -f "$FULL_DEST")

        if [ "$CURRENT_TARGET" == "$FULL_SRC" ]; then
            echo "⏩ Skipped: $LINK_NAME (Already correct)"
            continue
        fi 
        echo "♻  Updating link: $LINK_NAME (Was pointing to wrong location)"

    elif [ -e "$FULL_DEST" ]; then
          echo "⚠ Warning: Overwriting existing real file: $LINK_NAME"
    fi


    ln -sf "$FULL_SRC" "$FULL_DEST"
    echo "✅ Linked: $SRC_FILE -> $LINK_NAME"
done

echo "------------------------------------------------"
