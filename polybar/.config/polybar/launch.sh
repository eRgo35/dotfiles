#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Rescan fonts - just to make sure we have what we need
fc-cache -fv

# Launch bar
echo "---" >> /tmp/polybar.log

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	  MONITOR=$m polybar -c $(dirname $0)/config.ini --reload master >>/tmp/polybar.log 2>&1 &
  done
else
	polybar -c $(dirname $0)/config.ini --reload master >>/tmp/polybar.log 2>&1 &
fi
echo "Bars launched..."
