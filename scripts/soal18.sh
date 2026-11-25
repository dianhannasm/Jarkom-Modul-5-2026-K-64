cat > /root/soal18.sh <<'EOF'
#!/bin/sh
set -e

CHAIN="SOAL18_SHIGERU"
MONOLITH="192.243.4.80/29"
RADAR="192.243.4.88/29"
TERMINAL="192.243.4.56/29"

# Buat chain khusus
iptables -N "$CHAIN" 2>/dev/null || true
iptables -F "$CHAIN"

# Pasang chain di awal FORWARD, tanpa duplikasi
iptables -C FORWARD -j "$CHAIN" 2>/dev/null || \
iptables -I FORWARD 1 -j "$CHAIN"

# Izinkan balasan koneksi yang dimulai dari dalam zona
iptables -A "$CHAIN" -d "$MONOLITH" \
    -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -A "$CHAIN" -d "$RADAR" \
    -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Pengecualian: ping dari subnet Terminal
iptables -A "$CHAIN" -i eth0 -s "$TERMINAL" -d "$MONOLITH" \
    -p icmp --icmp-type echo-request -j ACCEPT

iptables -A "$CHAIN" -i eth0 -s "$TERMINAL" -d "$RADAR" \
    -p icmp --icmp-type echo-request -j ACCEPT

# Tolak koneksi baru dari arah Gendo ke zona
iptables -A "$CHAIN" -i eth0 -d "$MONOLITH" -j DROP
iptables -A "$CHAIN" -i eth0 -d "$RADAR" -j DROP

# Traffic lainnya tidak diubah
iptables -A "$CHAIN" -j RETURN

echo "Konfigurasi Soal 18 berhasil."
iptables -L "$CHAIN" -n -v --line-numbers
EOF

chmod +x /root/soal18.sh
/root/soal18.sh