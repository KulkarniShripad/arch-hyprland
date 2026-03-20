#!/bin/bash

chosen=$(printf "Shutdown\nReboot\nSuspend\nLogout" | rofi -dmenu -p "Power")

case "$chosen" in
  Shutdown) systemctl poweroff ;;
  Reboot) systemctl reboot ;;
  Suspend) systemctl suspend ;;
  Logout) hyprctl dispatch exit ;;
esac

