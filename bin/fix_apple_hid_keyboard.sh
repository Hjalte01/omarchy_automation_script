#!/bin/bash


GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${YELLOW}Starting keyboard Configuration...${RESET}"

# ----------------------------------------------------------------
# 1. KEYBOARD CONFIGURATION (Fix for Apple-layout Keyboards)
# ----------------------------------------------------------------
# Only apply this if you are using your specific mechanical keyboard
# that requires the 'hid_apple' driver to behave like Windows.

# File path for the config
CONF_FILE="/etc/modprobe.d/hid_apple.conf"
CONF_CONTENT="options hid_apple fnmode=1 swap_opt_cmd=1"

echo -e "\n[Keyboard] Checking for Apple-layout fix..."

# Check if the config already exists
if grep -q "fnmode=1" "$CONF_FILE" 2>/dev/null; then
    echo -e "${GREEN}✔ Keyboard is already configured.${RESET}"
else
    # Ask user before applying (Safety check for other machines)
    read -p "Do you want to apply the Apple-to-Windows Keyboard fix? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        echo "Applying fix..."
        echo "$CONF_CONTENT" | sudo tee "$CONF_FILE" > /dev/null
        
        # Reload the driver immediately so you don't have to reboot
        echo "Reloading kernel module..."
        sudo rmmod hid_apple 2>/dev/null
        sudo modprobe hid_apple
        
        echo -e "${GREEN}✔ Keyboard fix applied!${RESET}"
    else
        echo "Skipping keyboard fix."
    fi
fi


echo -e "\n${GREEN}Keyboard setup complete.${RESET}"
