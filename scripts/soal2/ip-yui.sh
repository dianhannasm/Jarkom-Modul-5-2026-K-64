cat > /root/ip-soal2.sh <<'EOF'
#!/bin/sh

ip link set eth0 up
ip addr replace 192.243.4.110/30 dev eth0

ip link set eth1 up
ip addr replace 192.243.3.1/25 dev eth1

ip link set eth2 up
ip addr replace 192.243.4.137/30 dev eth2

ip link set eth3 up
ip addr replace 192.243.4.141/30 dev eth3

ip link set eth4 up
ip addr replace 192.243.4.145/30 dev eth4

echo "IP Yui selesai"
EOF

chmod +x /root/ip-soal2.sh
/root/ip-soal2.sh