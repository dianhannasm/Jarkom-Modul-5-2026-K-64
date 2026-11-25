cat > /root/ip-soal2.sh <<'EOF'
#!/bin/sh

ip link set eth0 up
ip addr replace 192.243.4.138/30 dev eth0

ip link set eth1 up
ip addr replace 192.243.4.33/28 dev eth1

echo "IP Mari selesai"
EOF

chmod +x /root/ip-soal2.sh
/root/ip-soal2.sh