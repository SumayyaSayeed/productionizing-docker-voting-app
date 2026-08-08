#!/bin/bash

set -e

APP_DIR="/opt/example-voting-app"

BUCKET_NAME=$1

mkdir -p "$APP_DIR"

cd "$APP_DIR"

echo "Downloading deployment bundle..."

aws s3 cp \
s3://votingappbucket/latest/deployment.tar.gz \
deployment.tar.gz

tar -xzf deployment.tar.gz

echo "Pull latest images..."

docker compose pull

echo "Restart application..."

docker compose up -d --remove-orphans

echo "Cleanup..."

docker image prune -af

echo "Deployment Completed"