#!/bin/sh
set -e

apk update
apk add netcat-openbsd

# Cek apakah listener sudah tersedia
if netstat -lnt | grep -q ':9000 '; then
    echo "Listener 9000 sudah aktif"
else
    nohup /usr/bin/nc -4 -l -k -d 9000 \
        >> /root/port-9000.log 2>&1 \
        < /dev/null &
fi

sleep 1
hostname
netstat -lnt
