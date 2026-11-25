
#!/bin/sh

# SOAL 5 - Firewall Gendou

WAN="eth0"
INTERNAL="192.243.0.0/21"

# Mengaktifkan IP forwarding
sysctl -w net.ipv4.ip_forward=1

# Membersihkan rule firewall sebelumnya
iptables -F INPUT
iptables -F FORWARD

iptables -P OUTPUT ACCEPT

# Mengizinkan loopback
iptables -A INPUT -i lo -j ACCEPT

# Mengizinkan balasan koneksi yang sudah ada
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Mengizinkan DHCP dari NAT1
iptables -A INPUT -i "$WAN" -p udp --sport 67 --dport 68 -j ACCEPT

# Mengizinkan internal menuju internet
iptables -A FORWARD ! -i "$WAN" -s "$INTERNAL" -o "$WAN" -j ACCEPT

# Mengizinkan komunikasi antar-LAN
iptables -A FORWARD ! -i "$WAN" ! -o "$WAN" -s "$INTERNAL" -d "$INTERNAL" -j ACCEPT

# Mengizinkan jaringan internal menuju Gendou
iptables -A INPUT ! -i "$WAN" -s "$INTERNAL" -j ACCEPT

# Default policy
iptables -P INPUT DROP
iptables -P FORWARD DROP
