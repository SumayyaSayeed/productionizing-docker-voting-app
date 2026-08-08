#!/bin/bash
set -euxo pipefail

# Log all output
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

echo "================================================="
echo "Starting EC2 Bootstrap"
echo "================================================="

# Update packages
dnf update -y

# Install required packages
dnf install -y \
    docker \
    git \
    unzip \
    awscli
#Install Docker Compose
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL \
https://github.com/docker/compose/releases/download/v2.39.1/docker-compose-linux-x86_64 \
-o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
# Enable Docker
systemctl enable docker
systemctl start docker

# Add ec2-user to docker group
usermod -aG docker ec2-user

# Verify installations
echo "================================================="
echo "Installed Versions"
echo "================================================="

docker --version
docker compose version
aws --version
git --version

echo "================================================="
echo "Docker Status"
echo "================================================="

systemctl status docker --no-pager

echo "================================================="
echo "Bootstrap Completed Successfully"
echo "================================================="