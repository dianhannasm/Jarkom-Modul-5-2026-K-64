#!/bin/sh
iptables -S
ping -c 3 -W 2 192.243.4.58
nc -zv -w 3 192.243.4.58 5000
echo "Exit code: $?"
ping -c 3 8.8.8.8
