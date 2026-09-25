#!/bin/bash
sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
/usr/sbin/sshd
python3 /app/ws.py
