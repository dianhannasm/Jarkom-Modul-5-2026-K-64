#!/bin/sh
# Jalankan setelah backup berhasil, satu node per giliran.
# Jika terjadi error setelah destroy, jalankan restore secara manual dari console.
set -e
sh /root/soal20.sh verify
sh /root/soal20.sh destroy
echo "=== RESTORE PERTAMA ==="
sh /root/soal20.sh restore
sh /root/soal20.sh verify
echo "=== RESTORE KEDUA ==="
sh /root/soal20.sh restore
sh /root/soal20.sh verify
