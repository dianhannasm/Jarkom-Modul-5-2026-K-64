#!/bin/sh
# Mulai capture pada link Switch-Medic ke Pen-Pen terlebih dahulu.
echo "Bukti DNAT setelah restore soal 20" | nc -N -w 3 192.243.4.82 9000
echo "Exit code: $?"
