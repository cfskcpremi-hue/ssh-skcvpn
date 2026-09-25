#!/bin/bash

# Buat sertifikat SSL otomatis untuk Stunnel
openssl req -new -x509 -days 365 -nodes \
    -out /etc/stunnel/stunnel.pem \
    -keyout /etc/stunnel/stunnel.pem \
    -subj "/C=ID/ST=Jakarta/L=Jakarta/O=SKC/CN=railway.app"

chmod 600 /etc/stunnel/stunnel.pem

# Jalankan SSH server di port internal 2222
sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
/usr/sbin/sshd

# Jalankan Stunnel di port 443 (foreground)
stunnel4 /etc/stunnel/stunnel.conf
