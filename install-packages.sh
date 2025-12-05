#!/bin/bash

# --- COLORS FOR PRETTY OUTPUT ---
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# --- PACKAGE LIST ---
# Add all your packages here
PKGS=(
    "hyprland"
    "waybar"
    "tmux"
    "stow"
    "firefox"
    "ghostty"
    "fastfetch"
    "keyd"
        # INSERT_HERE
)

# --- TRACKING ARRAYS ---
SUCCESS_LIST=()
FAILED_LIST=()

echo -e "${YELLOW}Starting installation process...${RESET}"

# --- INSTALL LOOP ---
for PKG in "${PKGS[@]}"; do
    echo -e "${YELLOW}----------------------------------------${RESET}"
    echo -e "${YELLOW}Processing: $PKG${RESET}"
    
    # Try to install ( --needed skips if present, --noconfirm avoids yes/no prompts)
    yay -S --needed --noconfirm "$PKG"

    # Check the exit code of the last command
    if pacman -Qi "$PKG" &> /dev/null; then
        echo -e "${GREEN}✔ Success: $PKG${RESET}"
        SUCCESS_LIST+=("$PKG")
    else
        echo -e "${RED}✘ Failed: $PKG${RESET}"
        FAILED_LIST+=("$PKG")
    fi
done

# --- FINAL SUMMARY ---
echo ""
echo -e "${YELLOW}========================================${RESET}"
echo -e "${YELLOW}           INSTALLATION SUMMARY         ${RESET}"
echo -e "${YELLOW}========================================${RESET}"

# Print Successful packages
if [ ${#SUCCESS_LIST[@]} -gt 0 ]; then
    echo -e "${GREEN}INSTALLED / UPDATED / SKIPPED:${RESET}"
    for ITEM in "${SUCCESS_LIST[@]}"; do
        echo -e "  • $ITEM"
    done
fi

echo ""

# Print Failed packages
if [ ${#FAILED_LIST[@]} -gt 0 ]; then
    echo -e "${RED}ERRORS ENCOUNTERED:${RESET}"
    for ITEM in "${FAILED_LIST[@]}"; do
        echo -e "  • $ITEM"
    done
    echo ""
    echo -e "${RED}Please check the logs above to see why these failed.${RESET}"
else
    echo -e "${GREEN}All packages processed successfully!${RESET}"
fi

echo ""
