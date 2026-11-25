#!/bin/sh

# Aktifkan interface WAN
ip link set eth0 up

# Minta alamat IP dari NAT1
if command -v udhcpc >/dev/null 2>&1; then
    udhcpc -i eth0
elif command -v dhclient >/dev/null 2>&1; then
    dhclient eth0
else
    echo "DHCP client tidak ditemukan"
    exit 1
fi

# Aktifkan IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "Konfigurasi Gendo selesai"