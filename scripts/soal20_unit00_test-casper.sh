#!/bin/sh
nc -zv -w 3 192.243.4.58 5000
echo "Exit code: $?"
