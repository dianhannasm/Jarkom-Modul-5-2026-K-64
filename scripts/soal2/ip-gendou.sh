cat > /root/ip-soal2.sh <<'EOF'
#!/bin/sh

ip link set eth1 up
ip addr replace 192.243.4.105/30 dev eth1

ip link set eth2 up
ip addr replace 192.243.4.133/30 dev eth2

ip link set eth3 up
ip addr replace 192.243.4.129/30 dev eth3

ip link set eth4 up
ip addr replace 192.243.4.125/30 dev eth4

ip link set eth5 up
ip addr replace 192.243.4.121/30 dev eth5

ip link set eth6 up
ip addr replace 192.243.4.117/30 dev eth6

ip link set eth7 up
ip addr replace 192.243.4.113/30 dev eth7

ip link set eth8 up
ip addr replace 192.243.4.109/30 dev eth8

echo "IP Gendo selesai"
EOF

chmod +x /root/ip-soal2.sh
/root/ip-soal2.sh