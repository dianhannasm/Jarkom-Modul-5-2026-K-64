#!/bin/sh
echo "=== HOSTNAME ==="
hostname
echo "=== SCRIPT TERSEDIA ==="
ls -l /root
echo "=== ROUTING ==="
ip route
echo "=== FIREWALL FILTER ==="
iptables -S
echo "=== FIREWALL NAT ==="
iptables -t nat -S
echo "=== JUMLAH BARIS FILTER ==="
iptables -S | wc -l
echo "=== JUMLAH BARIS NAT ==="
iptables -t nat -S | wc -l
echo "=== LISTENER ==="
netstat -lnt
