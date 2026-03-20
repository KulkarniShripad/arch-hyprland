#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpaper"
CACHE_WALLPAPER="$HOME/.cache/hyprlock_wallpaper.png"

# Start swww daemon if not running
if ! pgrep -x swww-daemon > /dev/null; then
  swww-daemon &
  sleep 1
fi

# Pick a random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( \
  -iname '*.png' -o \
  -iname '*.jpg' -o \
  -iname '*.jpeg' -o \
  -iname '*.bmp' -o \
  -iname '*.webp' \
\) | shuf -n 1)

# Exit if none found
if [[ -z "$WALLPAPER" ]]; then
  notify-send "Wallpaper Error" "No images found in $WALLPAPER_DIR"
  exit 1
fi

# Copy the wallpaper to cache for hyprlock
cp "$WALLPAPER" "$CACHE_WALLPAPER"

# Set wallpaper using swww
swww img "$WALLPAPER" \
  --transition-type grow \
  --transition-duration 0.8 \
  --transition-fps 60

# Generate pywal colors (without resetting wallpaper)
~/.config/hypr/scripts/pywal-hyprland.sh
wal -i "$WALLPAPER" -n

# Reload waybar
killall -SIGUSR2 waybar

