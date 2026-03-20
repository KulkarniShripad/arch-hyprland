#!/bin/bash

MODE="$1"
TMPFILE="/tmp/screenshot_$(date +%s).png"
FINALDIR="$HOME/Pictures/Screenshots"

case "$MODE" in
  area)
    grim -g "$(slurp)" "$TMPFILE"
    ;;
  window)
    grim -g "$(slurp -w 0)" "$TMPFILE"
    ;;
  screen)
    grim "$TMPFILE"
    ;;
  *)
    exit 1
    ;;
esac

# If screenshot was cancelled
[ ! -f "$TMPFILE" ] && exit 1

CHOICE=$(printf "Copy to clipboard\nSave\nDiscard" | rofi -dmenu -p "Screenshot" -theme ~/.config/rofi/applets/type-1/style-1.rasi)

case "$CHOICE" in
  "Copy to clipboard")
    wl-copy < "$TMPFILE"
    notify-send \
      -a "Screenshot" \
      -i "$TMPFILE" \
      -h string:image-path:"$TMPFILE" \
      "Screenshot copied" "Image copied to clipboard"
    rm "$TMPFILE"
    ;;

  "Save")
    mkdir -p "$FINALDIR"
    FINALFILE="$FINALDIR/$(basename "$TMPFILE")"
    mv "$TMPFILE" "$FINALFILE"

    notify-send \
      -a "Screenshot" \
      -i "$FINALFILE" \
      -h string:image-path:"$FINALFILE" \
      "Screenshot saved" "$(basename "$FINALFILE")"
    ;;

  "Discard")
    rm "$TMPFILE"
    notify-send \
      -a "Screenshot" \
      "Screenshot discarded"
    ;;

  *)
    rm "$TMPFILE"
    ;;
esac

