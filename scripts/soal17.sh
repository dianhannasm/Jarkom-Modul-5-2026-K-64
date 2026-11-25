cat > /root/soal17.sh <<'EOF'
#!/bin/sh
set -e

CASPER_IP="192.243.4.58"
ZERUEL_IP="192.243.4.82"
PENPEN_IP="192.243.3.195"
PORT="9000"
CHAIN="SOAL17_REDIRECT"

# Pastikan IP forwarding aktif
sysctl -w net.ipv4.ip_forward=1

# Buat chain khusus Soal 17
iptables -t nat -N "$CHAIN" 2>/dev/null || true

# Bersihkan hanya chain milik Soal 17
iptables -t nat -F "$CHAIN"

# Alihkan TCP Casper -> Zeruel port 9000
iptables -t nat -C PREROUTING \
    -i eth1 -s "$CASPER_IP" -d "$ZERUEL_IP" \
    -p tcp --dport "$PORT" -j "$CHAIN" 2>/dev/null || \
iptables -t nat -I PREROUTING 1 \
    -i eth1 -s "$CASPER_IP" -d "$ZERUEL_IP" \
    -p tcp --dport "$PORT" -j "$CHAIN"

# DNAT menuju Pen-Pen
iptables -t nat -A "$CHAIN" \
    -p tcp --dport "$PORT" \
    -j DNAT --to-destination "$PENPEN_IP:$PORT"

echo "Konfigurasi Soal 17 berhasil."
echo "Casper  : $CASPER_IP"
echo "Zeruel  : $ZERUEL_IP:$PORT"
echo "Pen-Pen : $PENPEN_IP:$PORT"

iptables -t nat -L PREROUTING -n -v --line-numbers
iptables -t nat -L "$CHAIN" -n -v --line-numbers
EOF

chmod +x /root/soal17.sh
/root/soal17.sh