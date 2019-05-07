#!/bin/bash
free | awk '/Mem:/ {print "scale=2;" $3 " * 100 / " $2}' | bc
