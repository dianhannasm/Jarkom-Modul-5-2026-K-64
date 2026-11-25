#!/bin/sh
echo "=== PING GATEWAY ==="
ping -c 2 -W 2 192.243.4.81

echo "=== TEST SEELE ==="
ping -c 2 -W 2 8.8.8.8
nc -zv -w 3 8.8.8.8 53

echo "=== TEST ZERUEL ==="
ping -c 2 -W 2 192.243.4.82
nc -zv -w 3 192.243.4.82 9000

echo "=== TEST LILITH ==="
ping -c 2 -W 2 192.243.4.74
nc -zv -w 3 192.243.4.74 9000
