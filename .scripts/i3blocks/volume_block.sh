#!/bin/bash

case $BLOCK_BUTTON in
  1) amixer -q sset Master,0 toggle ;;
  3) ~/.scripts/i3/sound_switcher.sh > /dev/null ;;
  4) amixer -q sset Master,0 2+ unmute ;;
  5) amixer -q sset Master,0 2- unmute ;;
esac

if ( amixer sget Master | grep -q off)
then
  echo -n -e '\xef\x9a\xa9 '  #   volume-mute
elif ( amixer get "Headphone" | grep -q off )
then
  echo -n -e '\xef\x80\xa8 '  #   volume-up
else
  echo -n -e '\xef\x80\xa5 '  #   Headphones
fi
amixer sget Master | grep -o [0-9]*%
