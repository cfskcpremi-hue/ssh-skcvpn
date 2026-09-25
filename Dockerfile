FROM python:3.9-slim

RUN apt-get update && apt-get install -y openssh-server && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/run/sshd

# Instal pustaka websockets untuk Python
RUN pip install --no-cache-dir websockets

# Buat user SSH (Username: ridsvpn, Password: kancil)
RUN useradd -ms /bin/bash ridsvpn && echo 'ridsvpn:kancil' | chpasswd
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

WORKDIR /app
COPY ws.py /app/ws.py
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 443 80
ENTRYPOINT ["/entrypoint.sh"]
