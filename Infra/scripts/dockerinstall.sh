#!/bin/bash
set -euxo pipefail

# Log everything
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

echo "===== Starting User Data Script ====="

# Update package index
apt-get update

# Install required packages
apt-get install -y \
    docker.io \
    docker-compose-v2 \
    curl \
    git \
    unzip

# Enable Docker service
systemctl enable docker

# Start Docker
systemctl start docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Verify installation
docker --version
docker compose version

echo "===== Docker Installation Completed ====="