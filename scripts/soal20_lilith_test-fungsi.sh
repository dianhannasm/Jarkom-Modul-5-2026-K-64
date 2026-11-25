#!/bin/sh
ping -c 3 -W 2 192.243.4.58
time nc -zv -w 3 192.243.4.59 5000
echo "Exit code: $?"
time nc -zv -w 3 192.243.4.59 5001
echo "Exit code: $?"
