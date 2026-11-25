cat > /root/soal4.sh <<'EOF'
#!/bin/sh

# Aktifkan IPv4 forwarding
sysctl -w net.ipv4.ip_forward=1

# NAT hanya untuk prefix internal yang keluar melalui NAT1 (eth0)
iptables -t nat -C POSTROUTING \
  -s 192.243.0.0/21 -o eth0 -j MASQUERADE 2>/dev/null || \
iptables -t nat -A POSTROUTING \
  -s 192.243.0.0/21 -o eth0 -j MASQUERADE

echo "Konfigurasi NAT Soal 4 selesai."
EOF

chmod +x /root/soal4.sh
/root/soal4.sh