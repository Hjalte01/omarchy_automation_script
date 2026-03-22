#!/bin/bash

# Read the current global active opacity
CURRENT=$(hyprctl getoption decoration:active_opacity -j | jq -r '.float')

# If it's 1.0, drop it to 0.5 (Ghost Mode). Otherwise, put it back to 1.0 (Solid).
if awk "BEGIN {exit !($CURRENT > 0.9)}"; then
    hyprctl keyword decoration:active_opacity 0.2
else
    hyprctl keyword decoration:active_opacity 1.0
fi
