#!/bin/bash

CSS="$HOME/.cache/wal/colors.css"
OUT="$HOME/.cache/wal/colors-hyprland.conf"

# clear output
> "$OUT"

# extract CSS variables and convert to Hyprland format
sed -nE '
  s/^[[:space:]]*--([^:]+):[[:space:]]*(#[0-9A-Fa-f]{6});/\1 \2/p
' "$CSS" | while read -r name hex; do
  r=$((16#${hex:1:2}))
  g=$((16#${hex:3:2}))
  b=$((16#${hex:5:2}))
  echo "\$$name = rgb($r,$g,$b)" >> "$OUT"
done

#update the pywal colors in rofi 
pywal_colors="$HOME/.cache/wal/colors.sh"
rasi_file="$HOME/.config/rofi/colors/pywal.rasi"

# Source pywal colors
source "$pywal_colors"

# Write colors to Rofi file
cat > "$rasi_file" << EOF
* {
background: $color0;
foreground: $color7;
active:     $color2;
urgent:     $color1;
selected:   $color4;
background-alt: $color8;
}
EOF



