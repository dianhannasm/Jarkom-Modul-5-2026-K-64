#!/bin/sh
set -e
ls -l /root/magi-casper.rules /root/magi-casper.sh /root/soal20.sh
ip -br a
if ! ip -4 addr show dev eth0 | grep -q '192.243.4.58/29'; then
    sh /root/soal6.sh
fi
sh /root/soal20.sh restore
sh /root/soal20.sh verify
if ! netstat -lnt | grep -q ':5000 '; then
    rm -f /root/nc-5000.pid
    sh /root/soal7.sh
fi
netstat -lnt
