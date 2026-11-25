#!/bin/sh
set -e

# Pertahankan tujuan hardening
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT

# Pertahankan larangan ping masuk soal 11
iptables -C INPUT -p icmp --icmp-type echo-request -j DROP 2>/dev/null || \
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Izinkan balasan koneksi
iptables -C INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 2>/dev/null || \
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Izinkan koneksi baru menuju TCP 5000
iptables -C INPUT -p tcp --dport 5000 -m conntrack --ctstate NEW -j ACCEPT 2>/dev/null || \
iptables -A INPUT -p tcp --dport 5000 -m conntrack --ctstate NEW -j ACCEPT

# Hapus rule yang memblokir seluruh ICMP
while iptables -C INPUT -p icmp -j DROP 2>/dev/null
do
    iptables -D INPUT -p icmp -j DROP
done

# Hapus pemblokiran DNS keluar
while iptables -C OUTPUT -p udp --dport 53 -j DROP 2>/dev/null
do
    iptables -D OUTPUT -p udp --dport 53 -j DROP
done

echo "=== FIREWALL CASPER ==="
iptables -S

echo "=== LISTENER CASPER ==="
netstat -lnt

echo "Perbaikan soal 12 selesai"
