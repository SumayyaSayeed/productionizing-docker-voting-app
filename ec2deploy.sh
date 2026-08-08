#!/bin/bash

set -e

APP_DIR="/opt/votingapp"


cd "$APP_DIR"

echo "Pull latest images..."

docker compose pull

echo "Restart application..."

docker compose up -d --remove-orphans

echo "Cleanup..."

docker image prune -af

echo "Deployment Completed"