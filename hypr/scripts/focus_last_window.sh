#!/bin/bash

# Get focused window address
current=$(hyprctl activewindow -j | jq -r '.address')

# Get the previously focused window (2nd in focus history)
target=$(hyprctl clients -j | jq -r '
    sort_by(.focusHistoryID)
    | map(select(.address != "'$current'"))
    | .[0].address
')

# Focus it if it exists
if [ -n "$target" ] && [ "$target" != "null" ]; then
    hyprctl dispatch focuswindow "address:$target"
fi

