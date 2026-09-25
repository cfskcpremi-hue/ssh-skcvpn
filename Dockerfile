FROM ubuntu:latest

# Update dan instal OpenSSH server, stunnel4, python3, dan utilities
RUN apt-get update && apt-get install -y \
    openssh-server \
    stunnel4 \
    python3 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Buat direktori yang dibutuhkan SSH
RUN mkdir /var/run/sshd

# Buat user ridsvpn dengan password kancil
RUN useradd -ms /bin/bash ridsvpn && echo 'ridsvpn:kancil' | chpasswd

# Konfigurasi SSH dasar (izinkan password login)
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Salin script entrypoint untuk menjalankan SSH, Stunnel, dan WS Proxy secara bersamaan
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Buka port 80 dan 443
EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
