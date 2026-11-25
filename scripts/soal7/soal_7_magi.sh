
cat > /root/soal7.sh <<'EOF'
#!/bin/sh
set -e

NODE=$(hostname | tr '[:upper:]' '[:lower:]')

case "$NODE" in
    magi-casper)    PORTS="5000" ;;
    magi-balthasar) PORTS="5000 5001" ;;
    magi-melchior)  PORTS="5000" ;;
    *) echo "Bukan node MAGI"; exit 1 ;;
esac

# Instalasi paket
apk update
apk add iptables netcat-openbsd

# Menjalankan listener
for PORT in $PORTS; do
    PIDFILE="/root/nc-$PORT.pid"

    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        echo "Listener port $PORT sudah berjalan"
    else
        nohup /usr/bin/nc -4 -l -k -d "$PORT" \
            >> "/root/port-$PORT.log" \
            2>> "/root/error-$PORT.log" \
            < /dev/null &

        echo $! > "$PIDFILE"
        echo "Listener port $PORT dijalankan"
    fi
done

sleep 1
echo "=== LISTENER MAGI ==="
netstat -lnt
EOF

chmod +x /root/soal7.sh
sh /root/soal7.sh
