#!/bin/bash

# ---------------------
# Configuration
# ---------------------
DOMAIN="n8n.yourdomain.com"
USERNAME="admin"
PASSWORD="strongpassword"
TIMEZONE="Asia/Kolkata"
WORKDIR="$HOME/n8n"

# ---------------------
# Install Dependencies
# ---------------------
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl unzip docker.io docker-compose apt-transport-https ca-certificates gnupg2 software-properties-common

# Enable Docker
sudo systemctl enable docker
sudo usermod -aG docker ${USER}

# ---------------------
# Install Caddy (for HTTPS)
# ---------------------
sudo mkdir -p /etc/apt/keyrings
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | \
  sudo gpg --dearmor -o /etc/apt/keyrings/caddy-stable-archive-keyring.gpg

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | \
  sudo tee /etc/apt/sources.list.d/caddy-stable.list

sudo apt update
sudo apt install -y caddy

# ---------------------
# Setup Project Directory
# ---------------------
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# .env file
cat <<EOF > .env
WEBHOOK_URL=https://${DOMAIN}/
N8N_BASIC_AUTH_USER=${USERNAME}
N8N_BASIC_AUTH_PASSWORD=${PASSWORD}
GENERIC_TIMEZONE=${TIMEZONE}
EOF

# docker-compose.yml
cat <<EOF > docker-compose.yml
version: "3.7"

services:
  n8n:
    image: n8nio/n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - WEBHOOK_URL=\${WEBHOOK_URL}
      - N8N_BASIC_AUTH_USER=\${N8N_BASIC_AUTH_USER}
      - N8N_BASIC_AUTH_PASSWORD=\${N8N_BASIC_AUTH_PASSWORD}
      - GENERIC_TIMEZONE=\${GENERIC_TIMEZONE}
    volumes:
      - n8n_data:/home/node/.n8n

volumes:
  n8n_data:
EOF

# Start n8n
docker-compose up -d

# ---------------------
# Configure Caddy
# ---------------------
sudo tee /etc/caddy/Caddyfile > /dev/null <<EOF
${DOMAIN} {
    reverse_proxy 127.0.0.1:5678
}
EOF

sudo systemctl restart caddy

# ---------------------
# Done
# ---------------------
echo "✅ n8n is now live at: https://${DOMAIN}"
echo "🔐 Login with user: ${USERNAME}"
echo "📂 Project directory: ${WORKDIR}"
echo "🔁 Log out and log back in if Docker permission denied"

