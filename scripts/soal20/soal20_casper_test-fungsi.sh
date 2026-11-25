#!/bin/sh
echo "=== FIREWALL ==="
iptables -S
echo "=== INTERNET ==="
ping -c 3 8.8.8.8
echo "=== LISTENER ==="
netstat -lnt

echo "=== TEST BALTHASAR 5000 ==="
nc -zv -w 3 192.243.4.59 5000
echo "Exit code: $?"

echo "=== TEST BALTHASAR 5001 ==="
nc -zv -w 3 192.243.4.59 5001
echo "Exit code: $?"

echo "=== TEST ROUTING FUYUTSUKI ==="
ping -c 3 -W 2 192.243.4.82

echo "=== TEST DNAT FUYUTSUKI ==="
echo "Test DNAT soal 20" | nc -N -w 3 192.243.4.82 9000
echo "Exit code: $?"
