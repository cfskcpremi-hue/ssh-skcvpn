#!/bin/bash

# Buat direktori stunnel jika belum ada
mkdir -p /var/run/stunnel4 /etc/stunnel

# Buat sertifikat SSL otomatis
openssl req -new -x509 -days 365 -nodes \
    -out /etc/stunnel/stunnel.pem \
    -keyout /etc/stunnel/stunnel.pem \
    -subj "/C=ID/ST=Jakarta/L=Jakarta/O=SKC/CN=railway.app"

chmod 600 /etc/stunnel/stunnel.pem

# Jalankan SSH server di port internal 2222
/usr/sbin/sshd

# Jalankan Stunnel dalam mode foreground (supaya kontainer tidak mati)
stunnel4 /etc/stunnel/stunnel.conf &

echo "=================================================="
echo " Server Stunnel & SSH Berhasil Aktif!"
echo "=================================================="

# Menjaga kontainer tetap hidup
sleep infinity
