cat > /root/soal14.sh <<'EOF'
#!/bin/sh
set -e

# =====================================
# JADWAL ASLI (WIB dikonversi ke UTC)
# Nilai dapat dioverride untuk pengujian
# =====================================
PILOT_START="${PILOT_START:-01:00}"
PILOT_STOP="${PILOT_STOP:-09:00}"
PILOT_DAYS="${PILOT_DAYS:-Mon,Tue,Wed,Thu,Fri}"

STAF_START="${STAF_START:-10:00}"
STAF_STOP="${STAF_STOP:-16:00}"

CHAIN="SOAL14_PENPEN"

# Buat chain khusus jika belum ada
iptables -N "$CHAIN" 2>/dev/null || true

# Bersihkan hanya chain milik Soal 14
iptables -F "$CHAIN"

# Hubungkan chain ke INPUT jika belum terpasang
iptables -C INPUT -j "$CHAIN" 2>/dev/null || \
iptables -I INPUT 1 -j "$CHAIN"

# =====================================
# DUMMY SYSTEM: SELALU DITOLAK
# =====================================
for IP in 192.243.4.51 192.243.4.50 192.243.4.102
do
    iptables -A "$CHAIN" -s "$IP" -p icmp \
        --icmp-type echo-request \
        -j REJECT --reject-with icmp-admin-prohibited

    iptables -A "$CHAIN" -s "$IP" -p tcp --dport 80 \
        -j REJECT --reject-with tcp-reset
done

# =====================================
# FUNGSI ATUR JADWAL KELOMPOK
# =====================================
add_schedule() {
    IPS="$1"
    START="$2"
    STOP="$3"
    DAYS="$4"

    for IP in $IPS
    do
        if [ -n "$DAYS" ]; then
            iptables -A "$CHAIN" -s "$IP" -p icmp \
                --icmp-type echo-request \
                -m time --timestart "$START" \
                --timestop "$STOP" --weekdays "$DAYS" \
                -j ACCEPT

            iptables -A "$CHAIN" -s "$IP" -p tcp --dport 80 \
                -m time --timestart "$START" \
                --timestop "$STOP" --weekdays "$DAYS" \
                -j ACCEPT
        else
            iptables -A "$CHAIN" -s "$IP" -p icmp \
                --icmp-type echo-request \
                -m time --timestart "$START" \
                --timestop "$STOP" \
                -j ACCEPT

            iptables -A "$CHAIN" -s "$IP" -p tcp --dport 80 \
                -m time --timestart "$START" \
                --timestop "$STOP" \
                -j ACCEPT
        fi

        # Di luar jadwal, langsung ditolak
        iptables -A "$CHAIN" -s "$IP" -p icmp \
            --icmp-type echo-request \
            -j REJECT --reject-with icmp-admin-prohibited

        iptables -A "$CHAIN" -s "$IP" -p tcp --dport 80 \
            -j REJECT --reject-with tcp-reset
    done
}

# Pilot: Senin-Jumat
add_schedule \
    "192.243.4.66 192.243.4.67 192.243.4.68 192.243.3.130" \
    "$PILOT_START" "$PILOT_STOP" "$PILOT_DAYS"

# Staf Geofront: setiap hari
add_schedule \
    "192.243.4.74 192.243.4.75" \
    "$STAF_START" "$STAF_STOP" ""

# Trafik lainnya tidak dibatasi oleh Soal 14
iptables -A "$CHAIN" -j RETURN

echo "Firewall Soal 14 berhasil dikonfigurasi."
echo "Pilot: $PILOT_START-$PILOT_STOP UTC ($PILOT_DAYS)"
echo "Staf : $STAF_START-$STAF_STOP UTC (setiap hari)"

iptables -L "$CHAIN" -n -v --line-numbers
EOF

chmod +x /root/soal14.sh