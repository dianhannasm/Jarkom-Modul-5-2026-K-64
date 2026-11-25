#!/bin/sh
nc -zv -w 3 192.243.4.58 5000
echo "Exit code: $?"
nc -zv -w 3 192.243.4.59 5000
echo "Exit code: $?"
nc -zv -w 3 192.243.4.59 5001
echo "Exit code: $?"
