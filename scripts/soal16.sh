#!/bin/sh
set -e

CORE_IP="192.243.4.106"
DUMMY_IP="192.243.4.51"
CHAIN="SOAL16_SCAN"

iptables -N "$CHAIN" 2>/dev/null || true
iptables -F "$CHAIN"

iptables -C INPUT -s "$DUMMY_IP" -d "$CORE_IP" \
    -p tcp -m multiport --dports 22,23,3306 \
    -j "$CHAIN" 2>/dev/null || \
iptables -I INPUT 1 -s "$DUMMY_IP" -d "$CORE_IP" \
    -p tcp -m multiport --dports 22,23,3306 \
    -j "$CHAIN"

# Catat setiap percobaan koneksi TCP
iptables -A "$CHAIN" -p tcp \
    -j LOG --log-prefix "SCAN-NERV: " --log-level 4

# Tolak koneksi
iptables -A "$CHAIN" -p tcp \
    -j REJECT --reject-with tcp-reset

echo "Firewall Soal 16 berhasil dikonfigurasi."
iptables -L INPUT -n -v --line-numbers
iptables -L "$CHAIN" -n -v --line-numbers