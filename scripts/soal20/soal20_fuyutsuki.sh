#!/bin/sh
set -e
ip -4 route replace default via 192.243.4.133 dev eth0
ip -4 route replace 192.243.3.192/27 via 192.243.4.162 dev eth2
ip -4 route replace 192.243.4.72/29 via 192.243.4.166 dev eth3
