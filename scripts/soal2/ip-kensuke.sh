cat > /root/ip-soal2.sh <<'EOF'
#!/bin/sh

ip link set eth0 up
ip addr replace 192.243.4.154/30 dev eth0

ip link set eth1 up
ip addr replace 192.243.3.129/26 dev eth1

echo "IP Kensuke selesai"
EOF

chmod +x /root/ip-soal2.sh
/root/ip-soal2.sh