#!/bin/bash

languages=('us' 'hu')

current=$(setxkbmap -query | sed -n -e 's/^layout:\s*//p')
current_ind=-1

for i in ${!languages[@]}
do
  if [[ ${languages[$i]} = $current ]]
  then
    current_ind=$i
  fi
done

if [[  $current_ind = $(( ${#languages[@]} - 1 )) ]]
then
  new_ind=0
else
  new_ind=$(( $current_ind + 1 ))
fi

setxkbmap ${languages[$new_ind]}

pkill -SIGRTMIN+11 i3blocks
