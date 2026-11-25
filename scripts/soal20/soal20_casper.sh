#!/bin/sh
set -e
ip -4 route replace default via 192.243.4.57 dev eth0
