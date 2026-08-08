#!/bin/bash
set -euxo pipefail

# Log everything
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

echo "===== Starting User Data Script ====="

# Update system packages
dnf update -y

# Install required packages
dnf install -y \
    docker \
    git \
    curl \
    unzip

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Add ec2-user to docker group
usermod -aG docker ec2-user

# Install Docker Compose v2 (if not already available)
mkdir -p /usr/local/lib/docker/cli-plugins

curl -SL \
  https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -o /usr/local/lib/docker/cli-plugins/docker-compose

chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Verify installation
docker --version
docker compose version

echo "===== Docker Installation Completed ====="