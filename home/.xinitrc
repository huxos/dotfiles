#!/bin/sh

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export GDK_USE_XFT=1
export QT_XFT=true

xrdb -load ~/.Xresources

export DESKTOP_SESSION=gnome

fcitx -d &> /dev/null
start-pulseaudio-x11
compton -b
urxvtd -q -f -o
exec awesome
