cat > /root/lilith.sh <<'EOF'
#!/bin/sh
set -e
apk update
apk add netcat-openbsd
EOF

chmod +x /root/lilith.sh
sh /root/lilith.sh

echo "Halo Casper dari Lilith" | nc -N -w 3 192.243.4.58 5000

echo "Halo Balthasar dari Lilith port 5000" | nc -N -w 3 192.243.4.59 5000

echo "Halo Balthasar dari Lilith port 5001" | nc -N -w 3 192.243.4.59 5001

echo "Halo Melchior dari Lilith" | nc -N -w 3 192.243.4.60 5000
