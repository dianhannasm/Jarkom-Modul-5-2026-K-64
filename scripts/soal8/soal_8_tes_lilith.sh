
echo "=== TEST PEN-PEN PORT 80 ==="
nc -N -w 3 192.243.3.195 80 < /dev/null

echo "=== TEST TOKYO3-CORE PORT 80 ==="
nc -N -w 3 192.243.4.106 80 < /dev/null

echo "=== TEST TOKYO3-CORE PORT 8080 ==="
nc -N -w 3 192.243.4.106 8080 < /dev/null



echo "=== TEST PEN-PEN PORT 22 ==="
time nc -zv -w 5 192.243.3.195 22
echo "Exit code: $?"

echo "=== TEST TOKYO3-CORE PORT 22 ==="
time nc -zv -w 5 192.243.4.106 22
echo "Exit code: $?"
