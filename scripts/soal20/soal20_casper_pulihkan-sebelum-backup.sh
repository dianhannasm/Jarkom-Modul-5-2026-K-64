#!/bin/sh
# Pemulihan awal saat rule dan listener hilang, sebelum backup soal 20.
iptables -C INPUT -i lo -j ACCEPT 2>/dev/null || \
iptables -I INPUT 1 -i lo -j ACCEPT
sh /root/soal12.sh
if ! netstat -lnt | grep -q ':5000 '; then
    rm -f /root/nc-5000.pid
    sh /root/soal7.sh
fi
echo "=== FIREWALL ==="
iptables -S
echo "=== LISTENER ==="
netstat -lnt
echo "=== INTERNET ==="
ping -c 3 8.8.8.8
