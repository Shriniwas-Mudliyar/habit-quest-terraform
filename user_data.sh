#!/bin/bash

# Log everything for debugging
exec > /var/log/user-data.log 2>&1

echo "===== USER DATA SCRIPT START ====="


# =========================
# Update system
# =========================

apt update -y
apt upgrade -y


# =========================
# Install dependencies
# =========================

apt install -y docker.io git curl


# =========================
# Enable Docker
# =========================

systemctl enable docker
systemctl start docker


# =========================
# Add ubuntu user to docker group
# =========================

usermod -aG docker ubuntu


# =========================
# Install Docker Compose v2
# =========================

mkdir -p /home/ubuntu/.docker/cli-plugins

curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 \
-o /home/ubuntu/.docker/cli-plugins/docker-compose

chmod +x /home/ubuntu/.docker/cli-plugins/docker-compose

chown -R ubuntu:ubuntu /home/ubuntu/.docker


# =========================
# Wait for Docker fully ready
# =========================

sleep 15


# =========================
# Run deployment as ubuntu user
# =========================

sudo -u ubuntu bash << 'EOF'

cd /home/ubuntu

git clone https://github.com/Shriniwas-Mudliyar/habit-quest.git

cd habit-quest

# Start containers
/home/ubuntu/.docker/cli-plugins/docker-compose up -d --build

EOF


echo "===== USER DATA SCRIPT COMPLETE ====="