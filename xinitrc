#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

if [[ `xrandr | grep "HDMI[2-3] connected" | wc -l` -eq 2 ]];then 
  xrandr --output LVDS1 --off
  xrandr --output HDMI3 --auto --primary
  xrandr --output HDMI2 --auto --right-of HDMI3
fi

./.fehbg &
syndaemon -k -i 1 &
mpd &
clipmenud &
while true; do
 spectrwm 2> ~/.spectrwm.log
done
