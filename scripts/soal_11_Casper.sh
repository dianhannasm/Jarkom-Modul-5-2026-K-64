#!/bin/sh
set -e

# Blokir ICMP echo-request yang masuk
iptables -C INPUT -p icmp --icmp-type echo-request -j DROP 2>/dev/null || \
iptables -I INPUT 1 -p icmp --icmp-type echo-request -j DROP

echo "=== FIREWALL CASPER ==="
iptables -S

echo "=== LISTENER CASPER ==="
netstat -lnt

echo "Konfigurasi soal 11 selesai"
