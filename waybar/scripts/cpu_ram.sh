#!/bin/bash

# ---------- CPU ----------
CPU=$(awk -v FS=" " '/^cpu / {
  usage=($2+$4)*100/($2+$4+$5)
  printf "%.0f", usage
}' /proc/stat)

if [ "$CPU" -ge 80 ]; then
  CPU_COLOR="#f38ba8"   # red
else
  CPU_COLOR="#5FD7D7"   # cyan
fi

# ---------- RAM ----------
MEM_USED=$(free -m | awk '/Mem:/ { print $3 }')
MEM_TOTAL=$(free -m | awk '/Mem:/ { print $2 }')
MEM_PERCENT=$(( MEM_USED * 100 / MEM_TOTAL ))

MEM_GB=$(awk "BEGIN { printf \"%.1f\", $MEM_USED/1024 }")

if [ "$MEM_PERCENT" -ge 70 ]; then
  MEM_COLOR="#f9e2af"   # yellow
else
  MEM_COLOR="#B48EAD"   # purple
fi

# ---------- OUTPUT ----------
echo "<span foreground='$CPU_COLOR'> ${CPU}%</span>  <span foreground='$MEM_COLOR'>󰘚 ${MEM_GB}G</span>"

