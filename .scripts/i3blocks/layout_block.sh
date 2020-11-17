#!/bin/bash

case $BLOCK_BUTTON in
  1) ~/.scripts/i3/layout_switcher.sh > /dev/null ;;
esac

lang=$(setxkbmap -query | sed -n -e 's/^layout:\s*//p')

echo " ${lang^^}"
