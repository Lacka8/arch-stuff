#!/bin/bash

if ( amixer get "Headphone" | grep -q off ); then
  amixer set "Speaker" mute
  amixer set "Headphone" unmute
else
  amixer set "Headphone" mute
  amixer set "Speaker" unmute
fi
pkill -SIGRTMIN+10 i3blocks
