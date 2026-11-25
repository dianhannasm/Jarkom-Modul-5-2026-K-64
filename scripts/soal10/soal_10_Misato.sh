#!/bin/sh
set -e

# Hapus SNAT palsu pada Misato
while iptables -t nat -C POSTROUTING \
    -s 192.243.4.64/29 ! -d 192.243.0.0/16 \
    -o eth0 -j SNAT --to-source 172.31.99.1 2>/dev/null
do
    iptables -t nat -D POSTROUTING \
        -s 192.243.4.64/29 ! -d 192.243.0.0/16 \
        -o eth0 -j SNAT --to-source 172.31.99.1
done

echo "=== NAT MISATO ==="
iptables -t nat -S

echo "Perbaikan Misato selesai"
