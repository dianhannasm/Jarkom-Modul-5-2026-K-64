#!/bin/sh
ip route
iptables -t nat -S
iptables -t nat -L -n -v
