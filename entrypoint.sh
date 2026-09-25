#!/bin/bash

# Konfigurasi Stunnel untuk port 443 (meneruskan TLS ke port SSH internal 22)
cat <<EOF > /etc/stunnel/stunnel.conf
pid = /var/run/stunnel.pid
output = /var/log/stunnel.log

[ssh-stunnel]
accept = 443
connect = 127.0.0.1:22
cert = /etc/stunnel/stunnel.pem
EOF

# Generate self-signed SSL certificate untuk stunnel secara otomatis
openssl req -new -x509 -days 365 -nodes \
    -out /etc/stunnel/stunnel.pem \
    -keyout /etc/stunnel/stunnel.pem \
    -subj "/C=ID/ST=Jakarta/L=Jakarta/O=VPN/CN=railway.app" 2>/dev/null

# Jalankan Stunnel4
stunnel4

# Jalankan SSH server di port internal 22
/usr/sbin/sshd

echo "=========================================="
echo " SSH Server + WS + Stunnel Aktif di Railway"
echo " User     : ridsvpn"
echo " Password : kancil"
echo " Port 443 : Stunnel / TLS"
echo " Port 80  : WebSocket / HTTP Upgrade"
echo "=========================================="

# Menjaga container tetap berjalan
tail -f /var/log/stunnel.log
