#!/bin/sh
set -e

NODE=$(hostname | tr '[:upper:]' '[:lower:]')

case "$NODE" in
    quarters)       IP=192.243.0.2; P=23; GW=192.243.0.1 ;;
    comm-net)       IP=192.243.2.2; P=24; GW=192.243.2.1 ;;
    hangar-crew)    IP=192.243.3.2; P=25; GW=192.243.3.1 ;;
    sachiel)        IP=192.243.3.130; P=26; GW=192.243.3.129 ;;
    medic-bay)      IP=192.243.3.194; P=27; GW=192.243.3.193 ;;
    pen-pen)        IP=192.243.3.195; P=27; GW=192.243.3.193 ;;
    relay-node)     IP=192.243.3.226; P=27; GW=192.243.3.225 ;;
    garden-staff)   IP=192.243.4.2; P=27; GW=192.243.4.1 ;;
    dock-crew)      IP=192.243.4.34; P=28; GW=192.243.4.33 ;;
    entry-plug)     IP=192.243.4.50; P=29; GW=192.243.4.49 ;;
    dummy-plug)     IP=192.243.4.51; P=29; GW=192.243.4.49 ;;
    magi-casper)    IP=192.243.4.58; P=29; GW=192.243.4.57 ;;
    magi-balthasar) IP=192.243.4.59; P=29; GW=192.243.4.57 ;;
    magi-melchior)  IP=192.243.4.60; P=29; GW=192.243.4.57 ;;
    unit-01)        IP=192.243.4.66; P=29; GW=192.243.4.65 ;;
    unit-02)        IP=192.243.4.67; P=29; GW=192.243.4.65 ;;
    unit-00)        IP=192.243.4.68; P=29; GW=192.243.4.65 ;;
    lilith)         IP=192.243.4.74; P=29; GW=192.243.4.73 ;;
    adam)           IP=192.243.4.75; P=29; GW=192.243.4.73 ;;
    zeruel)         IP=192.243.4.82; P=29; GW=192.243.4.81 ;;
    armisael)       IP=192.243.4.83; P=29; GW=192.243.4.81 ;;
    radar-array)    IP=192.243.4.90; P=29; GW=192.243.4.89 ;;
    archive-vault)  IP=192.243.4.98; P=30; GW=192.243.4.97 ;;
    spy)            IP=192.243.4.102; P=30; GW=192.243.4.101 ;;
    tokyo3-core)    IP=192.243.4.106; P=30; GW=192.243.4.105 ;;
    *) echo "Hostname tidak dikenal: $NODE"; exit 1 ;;
esac

case "$P" in
    23) MASK=255.255.254.0 ;;
    24) MASK=255.255.255.0 ;;
    25) MASK=255.255.255.128 ;;
    26) MASK=255.255.255.192 ;;
    27) MASK=255.255.255.224 ;;
    28) MASK=255.255.255.240 ;;
    29) MASK=255.255.255.248 ;;
    30) MASK=255.255.255.252 ;;
esac

IFACE=eth0

# Backup konfigurasi lama
if [ -f /etc/network/interfaces ]; then
    cp -n /etc/network/interfaces /root/interfaces.bak
fi

# Konfigurasi permanen
cat > /etc/network/interfaces <<CONF
auto lo
iface lo inet loopback

auto $IFACE
iface $IFACE inet static
    address $IP
    netmask $MASK
    gateway $GW
    up echo nameserver 8.8.8.8 > /etc/resolv.conf
CONF

# Terapkan konfigurasi
ip link set "$IFACE" up
ip -4 addr flush dev "$IFACE" scope global
ip addr add "$IP/$P" dev "$IFACE"
ip route replace default via "$GW" dev "$IFACE"

echo "nameserver 8.8.8.8" > /etc/resolv.conf

echo "Konfigurasi $NODE selesai"
ip -br a
ip route
