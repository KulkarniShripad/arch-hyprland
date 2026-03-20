#!/bin/bash

STEP=5

case "$1" in
  up)
    pamixer -i $STEP
    ;;
  down)
    pamixer -d $STEP
    ;;
  mute)
    pamixer -t
    ;;
esac

VOLUME=$(pamixer --get-volume)
MUTED=$(pamixer --get-mute)

if [ "$MUTED" = "true" ]; then
  TEXT="Muted"
  ICON="audio-volume-muted"
else
  TEXT="Volume: ${VOLUME}%"
  ICON="audio-volume-high"
fi

notify-send \
  -a "volume" \
  -h int:value:"$VOLUME" \
  -h string:x-canonical-private-synchronous:volume \
  -i "$ICON" \
  "$TEXT"

