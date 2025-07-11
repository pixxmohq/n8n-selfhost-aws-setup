# 🚀 n8n Self-Hosting Script (AWS EC2 + Docker + Caddy + HTTPS)

Easily self-host [n8n](https://n8n.io) — the powerful workflow automation tool — on an AWS EC2 Ubuntu instance using Docker, Docker Compose, and Caddy for HTTPS.

---

## ⚙️ Features

* ✅ One-command install script
* ✅ Docker + Docker Compose-based deployment
* ✅ Secure HTTPS via Caddy and Let's Encrypt
* ✅ Automatic reverse proxy setup
* ✅ Works with subdomains like `n8n.yourdomain.com`
* ✅ Lightweight & production-ready

---

## 📦 Setup Instructions

### ⚠️ Important DNS Step

Before running the script, make sure your subdomain (e.g. n8n.yourdomain.com) is correctly pointed to your EC2's public IP:

  1. Go to your domain registrar's DNS settings
  2. Add an A record:
     - Host: n8n
     - Points to: your EC2 public IP
     - TTL: Auto or 600

Wait a few minutes for propagation, then proceed below.

### 1. 🔁 Clone the repo

```bash
git clone https://github.com/<your-username>/n8n-selfhost-aws-setup.git
cd n8n-selfhost-aws-setup
```

### 2. ⚙️ Configure the script

Edit the top variables in `setup-n8n.sh`:

```bash
DOMAIN="n8n.yourdomain.com"
USERNAME="admin"
PASSWORD="strongpassword"
TIMEZONE="Asia/Kolkata"
```

### 3. ✅ Run the setup script

```bash
chmod +x setup-n8n.sh
./setup-n8n.sh
```

Once complete, visit:

```
https://n8n.yourdomain.com
```

---

## 📝 Prerequisites

* An AWS EC2 Ubuntu instance (20.04 or 22.04 recommended)
* A subdomain (e.g. `n8n.pixxmo.com`) pointed via A record to your EC2 IP
* Domain should allow HTTPS provisioning via Let's Encrypt

---

## 🔐 Security Tips

* Set a strong username and password
* Never expose port `5678` directly — use reverse proxy only
* Use a firewall to block all unused ports (e.g., only allow 22, 80, 443)
* Optional: use PostgreSQL for persistence (instead of default SQLite)

---

## 📂 Project Structure

```
.
├── setup-n8n.sh       # Main installation script
└── README.md          # This file
└── LICENSE            # MIT License
```

---

## 🧠 About

This script is maintained by [Pixxmo](https://pixxmo.com) to help developers and indie founders launch their own workflow automation on their infrastructure.

Follow along as I build automation tools and SaaS products at [Pixxmo](https://pixxmo.com).

---

## 📄 License

MIT License — free for personal or commercial use.

