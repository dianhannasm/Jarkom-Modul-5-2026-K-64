cat > /root/ip-soal2.sh <<'EOF'
#!/bin/sh

ip link set eth0 up
ip addr replace 192.243.4.130/30 dev eth0

ip link set eth1 up
ip addr replace 192.243.4.81/29 dev eth1

ip link set eth2 up
ip addr replace 192.243.4.169/30 dev eth2

echo "IP Shigeru selesai"
EOF

chmod +x /root/ip-soal2.sh
/root/ip-soal2.sh