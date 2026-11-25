#!/bin/sh
set -e

# Hapus policy routing tambahan
ip rule del pref 90 iif eth1 lookup 100 2>/dev/null || true

# Hapus unreachable route
ip route del unreachable default table 100 2>/dev/null || true

# Hapus blackhole route
ip route del blackhole 192.243.4.72/29 2>/dev/null || true

# Pulihkan default route
ip route replace default via 192.243.4.129 dev eth0

# Aktifkan IP forwarding
sysctl -w net.ipv4.ip_forward=1

echo "=== ROUTING ==="
ip route

echo "=== IP RULE ==="
ip rule

echo "=== IP FORWARDING ==="
sysctl net.ipv4.ip_forward

echo "Perbaikan soal 9 selesai"
