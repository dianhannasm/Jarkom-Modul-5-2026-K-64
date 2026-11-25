cat > /root/soal3.sh <<'EOF'
#!/bin/sh

set -e

case "$(hostname)" in

  Yui)
    ip route replace default via 192.243.4.109 dev eth0
    ip route replace 192.243.0.0/23 via 192.243.4.142 dev eth3
    ip route replace 192.243.4.0/27 via 192.243.4.146 dev eth4
    ip route replace 192.243.4.32/28 via 192.243.4.138 dev eth2
    ;;

  Hikari)
    ip route replace default via 192.243.4.113 dev eth0
    ip route replace 192.243.3.224/27 via 192.243.4.150 dev eth2
    ;;

  Asuka)
    ip route replace default via 192.243.4.117 dev eth0
    ip route replace 192.243.3.128/26 via 192.243.4.154 dev eth3
    ip route replace 192.243.4.48/29 via 192.243.4.158 dev eth2
    ;;

  Fuyutsuki)
    ip route replace default via 192.243.4.133 dev eth0
    ip route replace 192.243.3.192/27 via 192.243.4.162 dev eth2
    ip route replace 192.243.4.72/29 via 192.243.4.166 dev eth3
    ;;

  Shigeru)
    ip route replace default via 192.243.4.129 dev eth0
    ip route replace 192.243.4.88/29 via 192.243.4.170 dev eth2
    ;;

  Misato)
    ip route replace default via 192.243.4.125 dev eth0
    ;;

  Kaji)
    ip route replace default via 192.243.4.121 dev eth0
    ;;

  Mari)
    ip route replace default via 192.243.4.137 dev eth0
    ;;

  Rei)
    ip route replace default via 192.243.4.141 dev eth0
    ;;

  Shinji)
    ip route replace default via 192.243.4.145 dev eth0
    ;;

  Kaworu)
    ip route replace default via 192.243.4.149 dev eth0
    ;;

  Kensuke)
    ip route replace default via 192.243.4.153 dev eth0
    ;;

  Ritsuko)
    ip route replace default via 192.243.4.157 dev eth0
    ;;

  Maya)
    ip route replace default via 192.243.4.161 dev eth0
    ;;

  Toji)
    ip route replace default via 192.243.4.165 dev eth0
    ;;

  Makoto)
    ip route replace default via 192.243.4.169 dev eth0
    ;;

  Gendou|Gendo)
    echo "Gendo: route sudah dikonfigurasi sebelumnya. Tidak diubah."
    ;;

  *)
    echo "Hostname tidak dikenali: $(hostname)"
    exit 1
    ;;
esac

echo "Static routing selesai untuk $(hostname)"
ip route
EOF

chmod +x /root/soal3.sh
/root/soal3.sh