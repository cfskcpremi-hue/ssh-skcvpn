#!/bin/bash

# Jalankan SSH server di port internal 2222
/usr/sbin/sshd

# Jalankan Haproxy untuk menghandle port 80 dan 443
haproxy -f /etc/haproxy/haproxy.cfg &

echo "=================================================="
echo " SSH Multi-Protocol Server Aktif di Railway"
echo " User     : ridsvpn"
echo " Password : kancil"
echo " Support  : Port 80 & 443 (WS, Stunnel, TLS, HTTPS, HTTP Upgrade)"
echo "=================================================="

# Menjaga container tetap hidup
sleep infinity
