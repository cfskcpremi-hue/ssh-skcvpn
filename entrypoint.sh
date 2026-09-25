#!/bin/bash

# Jalankan SSH server
/usr/sbin/sshd

# Buat direktori run haproxy jika belum ada
mkdir -p /run/haproxy

# Jalankan HAProxy dan cek error-nya secara langsung di log
haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid &

echo "=================================================="
echo " SSH Multi-Protocol Server Aktif di Railway"
echo " User     : ridsvpn"
echo " Password : kancil"
echo "=================================================="

sleep infinity
