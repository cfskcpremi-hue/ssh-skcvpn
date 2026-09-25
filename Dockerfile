FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    openssh-server \
    stunnel4 \
    && rm -rf /var/lib/apt/lists/*

# Buat direktori yang dibutuhkan SSH
RUN mkdir -p /var/run/sshd

# Buat user SSH (Username: ridsvpn, Password: kancil)
RUN useradd -ms /bin/bash ridsvpn && echo 'ridsvpn:kancil' | chpasswd
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

# Buka port 443 dan 80
EXPOSE 443 80

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
