#!/bin/sh
set -e

NODE=$(hostname | tr '[:upper:]' '[:lower:]')

case "$NODE" in
    fuyutsuki)
        ROUTES="default 192.243.3.192/27 192.243.4.72/29"
        ;;
    magi-casper|magi-balthasar)
        ROUTES="default"
        ;;
    *)
        echo "Node tidak sesuai"
        exit 1
        ;;
esac

DIR=/root/backup-soal20
RULES="/root/$NODE.rules"
SCRIPT="/root/$NODE.sh"

mkdir -p "$DIR"

case "${1:-}" in

backup)
    if [ -f "$DIR/backup.done" ]; then
        echo "Backup sudah tersedia"
        exit 1
    fi

    # Simpan kondisi awal
    iptables -S > "$DIR/filter-awal.txt"
    iptables -t nat -S > "$DIR/nat-awal.txt"
    iptables-save > "$RULES"
    ip -4 route | sort > "$DIR/route-awal.txt"

    # Validasi backup firewall
    iptables-restore --test < "$RULES"

    # Backup script lama
    if [ -f "$SCRIPT" ]; then
        cp -p "$SCRIPT" "$DIR/script-lama.sh"
    fi

    # Buat script pemulihan routing
    printf '#!/bin/sh\nset -e\n' > "$SCRIPT"

    for DEST in $ROUTES; do
        ROUTE=$(ip -4 route show exact "$DEST")

        if [ -z "$ROUTE" ]; then
            echo "Route $DEST tidak ditemukan"
            exit 1
        fi

        printf 'ip -4 route replace %s\n' "$ROUTE" >> "$SCRIPT"
    done

    chmod +x "$SCRIPT"
    touch "$DIR/backup.done"

    echo "=== BACKUP FIREWALL ==="
    ls -l "$RULES"

    echo "=== SCRIPT ROUTING ==="
    cat "$SCRIPT"

    echo "[OK] Backup $NODE selesai"
    ;;

destroy)
    test -f "$DIR/backup.done"
    iptables-restore --test < "$RULES"

    # Hapus rule firewall termasuk NAT
    for TABLE in $(sed -n 's/^\*//p' "$RULES"); do
        iptables -t "$TABLE" -F
        iptables -t "$TABLE" -X
    done

    # Hapus rute statis
    for DEST in $ROUTES; do
        ip -4 route del "$DEST"
    done

    echo "=== FILTER SETELAH DIHAPUS ==="
    iptables -S

    echo "=== NAT SETELAH DIHAPUS ==="
    iptables -t nat -S

    echo "=== ROUTING SETELAH DIHAPUS ==="
    ip route
    ;;

restore)
    test -f "$DIR/backup.done"

    iptables-restore < "$RULES"
    sh "$SCRIPT"

    echo "[OK] Restore $NODE selesai"
    ;;

verify)
    test -f "$DIR/backup.done"

    iptables -S > "$DIR/filter-now.txt"
    iptables -t nat -S > "$DIR/nat-now.txt"
    ip -4 route | sort > "$DIR/route-now.txt"

    echo "=== NODE ==="
    hostname

    echo "=== JUMLAH BARIS FILTER ==="
    wc -l "$DIR/filter-awal.txt"
    wc -l "$DIR/filter-now.txt"

    echo "=== JUMLAH BARIS NAT ==="
    wc -l "$DIR/nat-awal.txt"
    wc -l "$DIR/nat-now.txt"

    echo "=== JUMLAH BARIS ROUTING ==="
    wc -l "$DIR/route-awal.txt"
    wc -l "$DIR/route-now.txt"

    echo "=== PERBANDINGAN FILTER ==="
    diff -u "$DIR/filter-awal.txt" "$DIR/filter-now.txt"

    echo "=== PERBANDINGAN NAT ==="
    diff -u "$DIR/nat-awal.txt" "$DIR/nat-now.txt"

    echo "=== PERBANDINGAN ROUTING ==="
    diff -u "$DIR/route-awal.txt" "$DIR/route-now.txt"

    echo "[OK] Konfigurasi identik dengan kondisi awal"
    ;;

*)
    echo "Gunakan: $0 backup|destroy|restore|verify"
    exit 1
    ;;
esac
