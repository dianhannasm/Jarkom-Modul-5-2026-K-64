cat > /root/soal2.sh <<'EOF'
#!/bin/sh

echo 1 > /proc/sys/net/ipv4/ip_forward

echo "IP forwarding aktif"
echo "Status:"
cat /proc/sys/net/ipv4/ip_forward
EOF

chmod +x /root/soal2.sh