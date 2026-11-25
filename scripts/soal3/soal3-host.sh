cat > /root/soal3-hosts.sh <<'EOF'
#!/bin/sh

case "$(hostname)" in
  Armisael)
    IP="192.243.4.83/29"
    GW="192.243.4.81"
    ;;
  Zeruel)
    IP="192.243.4.82/29"
    GW="192.243.4.81"
    ;;
  Lilith)
    IP="192.243.4.74/29"
    GW="192.243.4.73"
    ;;
  Sachiel)
    IP="192.243.3.130/26"
    GW="192.243.3.129"
    ;;
  Comm-Net)
    IP="192.243.2.2/24"
    GW="192.243.2.1"
    ;;
  *)
    echo "Hostname tidak dikenali"
    exit 1
    ;;
esac

ip link set eth0 up
ip addr replace "$IP" dev eth0
ip route replace default via "$GW" dev eth0

echo "Konfigurasi selesai untuk $(hostname)"
ip -br addr
ip route
EOF

chmod +x /root/soal3-hosts.sh
/root/soal3-hosts.sh