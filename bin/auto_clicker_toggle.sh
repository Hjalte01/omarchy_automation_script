#!/bin/bash

PIDFILE=/tmp/clicker.pid
export YDOTOOL_SOCKET=/tmp/.ydotool_socket

# 1. CHECK IF CLICKER IS RUNNING
if [ -f "$PIDFILE" ]; then
    # --- STOPPING ---
    # Read the PID and kill the process
    if kill -0 $(cat "$PIDFILE") 2>/dev/null; then
        kill "$(cat "$PIDFILE")"
    fi
    # Clean up the file
    rm "$PIDFILE"
    notify-send "Autoclicker: OFF"
    exit
fi

# 2. DETERMINE SPEED
# If the argument is "ask", show a popup box
if [ "$1" == "ask" ]; then
    # Opens a GUI box to type the speed
    SPEED=$(zenity --entry --title="Autoclicker" --text="Enter delay in seconds (e.g. 0.01):" --entry-text="0.1")
    
    # If user pressed Cancel or empty, stop
    if [ -z "$SPEED" ]; then exit; fi
else
    # Otherwise, use the argument provided (or default to 0.1)
    SPEED=${1:-0.1}
fi

# 3. STARTING
# Run the loop with the chosen speed
(while true; do ydotool click 0xC0; sleep $SPEED; done) &

# Save the PID so we can kill it later
echo $! > "$PIDFILE"
notify-send "Autoclicker: ON (Delay: ${SPEED}s)"
