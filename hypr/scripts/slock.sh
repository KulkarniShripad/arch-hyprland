#!/usr/bin/env bash

set -e

WALLPAPER_DIR="$HOME/Pictures/Wallpaper"
CACHE_IMG="$HOME/.cache/hyprlock_wallpaper.png"

# Pick random image
IMAGE=$(find "$WALLPAPER_DIR" -type f \( \
  -iname '*.jpg' -o -iname '*.jpeg' -o \
  -iname '*.png' -o -iname '*.bmp' -o \
  -iname '*.webp' \
\) | shuf -n 1)

if [[ -z "$IMAGE" ]]; then
  echo "No lockscreen images found"
  exit 1
fi

# Get resolution (Wayland-safe)
RESOLUTION=$(hyprctl monitors -j | jq -r '.[0] | "\(.width)x\(.height)"')

if [[ -z "$RESOLUTION" ]]; then
  echo "Failed to detect screen resolution"
  exit 1
fi

# Generate lockscreen image
magick "$IMAGE" \
  -resize "${RESOLUTION}^" \
  -gravity center \
  -extent "$RESOLUTION" \
  "$CACHE_IMG"

# Lock screen
hyprlock

