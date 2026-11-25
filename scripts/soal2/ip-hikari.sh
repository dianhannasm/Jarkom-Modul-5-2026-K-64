cat > /root/ip-soal2.sh <<'EOF'
#!/bin/sh

ip link set eth0 up
ip addr replace 192.243.4.114/30 dev eth0

ip link set eth1 up
ip addr replace 192.243.2.1/24 dev eth1

ip link set eth2 up
ip addr replace 192.243.4.149/30 dev eth2

echo "IP Hikari selesai"
EOF

chmod +x /root/ip-soal2.sh
/root/ip-soal2.sh