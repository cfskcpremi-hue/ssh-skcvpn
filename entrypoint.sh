#!/bin/bash

# Buat sertifikat SSL mandiri (.pem)
openssl req -new -x509 -days 365 -nodes \
    -out /app/cert.pem \
    -keyout /app/key.pem \
    -subj "/C=ID/ST=Jakarta/L=Jakarta/O=SKC/CN=railway.app"

sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
/usr/sbin/sshd
python3 /app/ws.py
