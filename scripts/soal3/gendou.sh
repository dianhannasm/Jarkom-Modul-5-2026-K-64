
cat > /root/soal3.sh <<'EOF'
#!/bin/sh

# Default route Gendo tetap menuju NAT1
ip route replace default via 192.168.122.1 dev eth0

# Cabang Yui
ip route replace 192.243.0.0/23 via 192.243.4.110
ip route replace 192.243.3.0/25 via 192.243.4.110
ip route replace 192.243.4.0/27 via 192.243.4.110
ip route replace 192.243.4.32/28 via 192.243.4.110

# Cabang Hikari
ip route replace 192.243.2.0/24 via 192.243.4.114
ip route replace 192.243.3.224/27 via 192.243.4.114

# Cabang Asuka
ip route replace 192.243.3.128/26 via 192.243.4.118
ip route replace 192.243.4.48/29 via 192.243.4.118
ip route replace 192.243.4.96/30 via 192.243.4.118

# Cabang Kaji
ip route replace 192.243.4.100/30 via 192.243.4.122

# Cabang Misato
ip route replace 192.243.4.64/29 via 192.243.4.126

# Cabang Shigeru: Monolith dan Radar
ip route replace 192.243.4.80/28 via 192.243.4.130

# Cabang Fuyutsuki
ip route replace 192.243.3.192/27 via 192.243.4.134
ip route replace 192.243.4.56/29 via 192.243.4.134
ip route replace 192.243.4.72/29 via 192.243.4.134

echo "Routing Gendo selesai"
ip route
EOF

chmod +x /root/soal3.sh
/root/soal3.sh
