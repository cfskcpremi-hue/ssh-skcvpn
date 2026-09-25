FROM ubuntu:latest

# Update dan instal OpenSSH server, python3, haproxy, socat, dan utilities
RUN apt-get update && apt-get install -y \
    openssh-server \
    haproxy \
    python3 \
    python3-pip \
    socat \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Buat direktori yang dibutuhkan SSH
RUN mkdir -p /var/run/sshd

# Buat user ridsvpn dengan password kancil secara permanen
RUN useradd -ms /bin/bash ridsvpn && echo 'ridsvpn:kancil' | chpasswd

# Konfigurasi SSH yang bersih dan aman
RUN echo "Port 2222" >> /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Salin konfigurasi dan script entrypoint
COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Buka port 80 dan 443
EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
