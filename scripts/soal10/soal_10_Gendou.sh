#!/bin/sh
set -e

# Hapus RETURN yang menghalangi NAT Cage
while iptables -t nat -C POSTROUTING \
    -s 192.243.4.64/29 -o eth0 -j RETURN 2>/dev/null
do
    iptables -t nat -D POSTROUTING \
        -s 192.243.4.64/29 -o eth0 -j RETURN
done

# Pastikan NAT soal 4 tetap aktif
iptables -t nat -C POSTROUTING \
    -s 192.243.0.0/21 -o eth0 -j MASQUERADE 2>/dev/null || \
iptables -t nat -A POSTROUTING \
    -s 192.243.0.0/21 -o eth0 -j MASQUERADE

echo "=== NAT GENDOU ==="
iptables -t nat -S

echo "=== FIREWALL GENDOU ==="
iptables -S

echo "Perbaikan Gendou selesai"
