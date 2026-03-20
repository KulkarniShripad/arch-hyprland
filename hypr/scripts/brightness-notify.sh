#!/bin/bash

STEP=5

case "$1" in
  up)
    brightnessctl set +${STEP}%
    ;;
  down)
    brightnessctl set ${STEP}%-
    ;;
esac

BRIGHTNESS=$(brightnessctl -m | cut -d',' -f4 | tr -d '%')

notify-send \
  -a "brightness" \
  -h int:value:"$BRIGHTNESS" \
  -h string:x-canonical-private-synchronous:brightness \
  -i "display-brightness-symbolic" \
  "Brightness: ${BRIGHTNESS}%"

