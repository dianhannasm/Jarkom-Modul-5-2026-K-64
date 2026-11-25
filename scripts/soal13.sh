cat > /root/soal13.sh <<'EOF'
#!/bin/sh

# Whitelist Casper dan seluruh Pilot
for IP in \
    192.243.4.58 \
    192.243.4.66 \
    192.243.4.67 \
    192.243.4.68 \
    192.243.3.130
do
    iptables -C INPUT -p tcp -s "$IP" \
        -m multiport --dports 5000,5001 \
        -j ACCEPT 2>/dev/null || \
    iptables -I INPUT 1 -p tcp -s "$IP" \
        -m multiport --dports 5000,5001 \
        -j ACCEPT
done

# Tolak semua sumber lain dengan TCP RST
iptables -C INPUT -p tcp \
    -m multiport --dports 5000,5001 \
    -j REJECT --reject-with tcp-reset 2>/dev/null || \
iptables -A INPUT -p tcp \
    -m multiport --dports 5000,5001 \
    -j REJECT --reject-with tcp-reset

echo "Firewall Soal 13 berhasil dikonfigurasi."
EOF

chmod +x /root/soal13.sh
/root/soal13.sh