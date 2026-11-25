#!/bin/sh

echo "========================================"
echo "       PENGUJIAN HOST GEOFRONT"
echo "========================================"

for NODE in \
Quarters:192.243.0.2 \
Comm-Net:192.243.2.2 \
Hangar-Crew:192.243.3.2 \
Sachiel:192.243.3.130 \
Medic-Bay:192.243.3.194 \
Pen-Pen:192.243.3.195 \
Relay-Node:192.243.3.226 \
Garden-Staff:192.243.4.2 \
Dock-Crew:192.243.4.34 \
Entry-Plug:192.243.4.50 \
Dummy-Plug:192.243.4.51 \
Magi-Casper:192.243.4.58 \
Magi-Balthasar:192.243.4.59 \
Magi-Melchior:192.243.4.60 \
Unit-01:192.243.4.66 \
Unit-02:192.243.4.67 \
Unit-00:192.243.4.68 \
Lilith:192.243.4.74 \
Adam:192.243.4.75 \
Zeruel:192.243.4.82 \
Armisael:192.243.4.83 \
Radar-Array:192.243.4.90 \
Archive-Vault:192.243.4.98 \
Spy:192.243.4.102 \
Tokyo3-Core:192.243.4.106
do
    (
        NAME=${NODE%:*}
        IP=${NODE#*:}

        if ping -c 2 -W 2 "$IP" >/dev/null 2>&1; then
            printf "\033[32m[OK]\033[0m   %-18s %s\n" "$NAME" "$IP"
        else
            printf "\033[31m[FAIL]\033[0m %-18s %s\n" "$NAME" "$IP"
        fi
    ) &
done

wait
echo "========================================"
echo "           PENGUJIAN SELESAI"
echo "========================================"

