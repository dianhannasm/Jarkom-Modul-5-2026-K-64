
cat > /root/soal8.sh <<'EOF'
#!/bin/sh
set -e

NODE=$(hostname | tr '[:upper:]' '[:lower:]')

case "$NODE" in
    pen-pen) PORTS="80" ;;
    tokyo3-core) PORTS="80 8080" ;;
    *) echo "Node tidak sesuai"; exit 1 ;;
esac

# Instalasi paket
apk update
apk add iptables netcat-openbsd

# Menjalankan listener
for PORT in $PORTS; do
    if [ "$PORT" = "8080" ]; then
        MESSAGE="syifa imutz"
    else
        MESSAGE="Welcome to $(hostname)"
    fi

    PIDFILE="/root/nc-$PORT.pid"

    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        echo "Listener port $PORT sudah berjalan"
    else
        nohup sh -c '
            while true; do
                printf "%s\n" "$2" | /usr/bin/nc -4 -N -l "$1"
                sleep 0.2
            done
        ' _ "$PORT" "$MESSAGE" \
            >> "/root/port-$PORT.log" \
            2>> "/root/error-$PORT.log" \
            < /dev/null &

        echo $! > "$PIDFILE"
        echo "Listener port $PORT dijalankan"
    fi
done

sleep 1

echo "=== LISTENER ==="
hostname
netstat -lnt
EOF

chmod +x /root/soal8.sh
sh /root/soal8.sh

netstat -lnt