#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${YELLOW}Starting Peripheral Configuration...${RESET}"

# ----------------------------------------------------------------
# 1. KEY REMAPPING (keyd)
# ----------------------------------------------------------------
# Handles: Left Swap, Right AltGr/Ctrl logic.

echo -e "\n[Keyd] Checking Key Remapper..."

# 1. Install keyd if missing
if ! command -v keyd &> /dev/null; then
    echo "Installing keyd..."
    yay -S --needed --noconfirm keyd
    sudo systemctl enable --now keyd
fi

# 2. Sync Configuration
SOURCE_CONFIG="$HOME/omarchy-supplement/config/keyd_variants/win.conf"
DEST_CONFIG="/etc/keyd/default.conf"

if [ -f "$SOURCE_CONFIG" ]; then
    # Check if files differ
    if ! cmp -s "$SOURCE_CONFIG" "$DEST_CONFIG"; then
        echo -e "${YELLOW}New keyboard configuration found.${RESET}"
        read -p "Update keyd configuration map? (y/n): " choice
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            echo "Copying config to /etc/keyd/default.conf..."
            sudo cp "$SOURCE_CONFIG" "$DEST_CONFIG"
            
            echo "Reloading keyd..."
            sudo keyd reload
            echo -e "${GREEN}✔ Keymap updated.${RESET}"
        else
            echo "Skipping keymap update."
        fi
    else
        echo -e "${GREEN}✔ Keyd config is up to date.${RESET}"
    fi
else
    echo -e "${RED}❌ Error: Source config not found at $SOURCE_CONFIG${RESET}"
fi

# ----------------------------------------------------------------
# 3. DONE
# ----------------------------------------------------------------
echo -e "\n${GREEN}Peripheral setup complete.${RESET}"
