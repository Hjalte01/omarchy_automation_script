#!/bin/bash

set -e

# Install all packages in order
./install-packages.sh 

# Install overrides of hyprland
./install-hyprland-overrides.sh

# Install system links
./install-scripts.sh

# Install style scripts
./install-waybar-transparent.sh

# setup dotfiles 
# ./install-dotfiles.sh

# setup hardware
./bin/fix_apple_hid_keyboard.sh

# Check Health
./health-check.sh



