cat > /root/soal15.sh <<'EOF'
#!/bin/sh
set -e

CORE_IP="192.243.4.106"
CHAIN="SOAL15_CORE"

# Aktifkan chain khusus
iptables -N "$CHAIN" 2>/dev/null || true

# Bersihkan hanya chain milik Soal 15
iptables -F "$CHAIN"

# Pasang rule pada INPUT khusus ping menuju Tokyo3-Core
iptables -C INPUT -d "$CORE_IP" -p icmp \
    --icmp-type echo-request -j "$CHAIN" 2>/dev/null || \
iptables -I INPUT 1 -d "$CORE_IP" -p icmp \
    --icmp-type echo-request -j "$CHAIN"

# Izinkan rata-rata 5 ping per detik dengan burst awal 5
iptables -A "$CHAIN" \
    -m limit --limit 5/second --limit-burst 5 \
    -j ACCEPT

# Buang ping yang melebihi batas
iptables -A "$CHAIN" -j DROP

echo "Firewall Soal 15 berhasil dikonfigurasi."
echo "Target: $CORE_IP"
echo "Limit: 5 ping/detik, burst 5"
echo
iptables -L INPUT -n -v --line-numbers
iptables -L "$CHAIN" -n -v --line-numbers
EOF

chmod +x /root/soal15.sh