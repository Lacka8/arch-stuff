#!/bin/bash

if ( amixer get "Headphone" | grep -q off ); then
  amixer set "Speaker" mute
  amixer set "Headphone" unmute
  pkill -SIGRTMIN+10 i3blocks
else
  amixer set "Headphone" mute
  amixer set "Speaker" unmute
  pkill -SIGRTMIN+10 i3blocks
fi
