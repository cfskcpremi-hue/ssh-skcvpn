#!/bin/bash

# Jalankan SSH server di port internal 2222
/usr/sbin/sshd

# Jalankan HAProxy di background (&) agar tidak menahan proses
haproxy -f /etc/haproxy/haproxy.cfg &

echo "=================================================="
echo " SSH Multi-Protocol Server Aktif di Railway"
echo " User     : ridsvpn"
echo " Password : kancil"
echo " Support  : Port 80 & 443 (WS, Stunnel, TLS, HTTP)"
echo "=================================================="

# Menjaga container tetap hidup
sleep infinity
