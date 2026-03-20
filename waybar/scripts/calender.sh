#!/bin/bash

# Kill if already running (toggle behavior)
pkill gsimplecal && exit 0

# Adjust these if your bar position/height changes
BAR_HEIGHT=48
MARGIN_TOP=12

gsimplecal \
  --close-on-unfocus \
  --position top \
  --margin-top=$((BAR_HEIGHT + MARGIN_TOP)) \
  --margin-right=20

