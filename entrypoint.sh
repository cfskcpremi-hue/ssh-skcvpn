#!/bin/bash
mkdir -p /var/run/stunnel4 /etc/stunnel

openssl req -new -x509 -days 365 -nodes \
    -out /etc/stunnel/stunnel.pem \
    -keyout /etc/stunnel/stunnel.pem \
    -subj "/C=ID/ST=Jakarta/L=Jakarta/O=SKC/CN=railway.app"

chmod 600 /etc/stunnel/stunnel.pem

/usr/sbin/sshd
stunnel4 /etc/stunnel/stunnel.conf

sleep infinity
