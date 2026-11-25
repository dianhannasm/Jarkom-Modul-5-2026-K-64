cat > /root/ip-soal2.sh <<'EOF'
#!/bin/sh

ip link set eth0 up
ip addr replace 192.243.4.118/30 dev eth0

ip link set eth1 up
ip addr replace 192.243.4.97/30 dev eth1

ip link set eth2 up
ip addr replace 192.243.4.157/30 dev eth2

ip link set eth3 up
ip addr replace 192.243.4.153/30 dev eth3

echo "IP Asuka selesai"
EOF

chmod +x /root/ip-soal2.sh
/root/ip-soal2.sh