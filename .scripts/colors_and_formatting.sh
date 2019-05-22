#!/bin/bash
for i in 49 {40..47} {100..107} ; do
  for j in 39 {30..37} {90..97} ; do
    echo -e -n '\e['$i'm\e['$j'm\\e['$i'm\\e['$j'm '
  done
  echo -e '\e[0m'
done
