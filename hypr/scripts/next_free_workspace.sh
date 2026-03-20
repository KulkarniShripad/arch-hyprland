#!/bin/bash

MAX_WS=10   # how far you want to search (1–20)
found=""

# get occupied workspace ids (with windows)
occupied=$(hyprctl clients -j | jq -r '.[].workspace.id' | sort -n | uniq)

for i in $(seq 1 $MAX_WS); do
    if ! echo "$occupied" | grep -qx "$i"; then
        found="$i"
        break
    fi
done

# fallback (should never happen)
[ -z "$found" ] && found=1

if [ "$1" = "move" ]; then
    hyprctl dispatch movetoworkspace "$found"
fi

hyprctl dispatch workspace "$found"

