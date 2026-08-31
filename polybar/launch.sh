#!/usr/bin/env bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export DEFAULT_BATTERY=$(ls -1 /sys/class/power_supply/ 2>/dev/null | grep -E '^BAT' | head -n 1)
export DEFAULT_ADAPTER=$(ls -1 /sys/class/power_supply/ 2>/dev/null | grep -E '^(AC|ADP)' | head -n 1)

polybar example 2>&1 | tee -a /tmp/polybar.log & disown
