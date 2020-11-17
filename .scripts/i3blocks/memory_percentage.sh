#!/bin/bash

mem=$(free | awk '/Mem:/ {print "scale=0;" $3 " * 100 / " $2}' | bc)

echo " $mem%"

