#!/bin/bash

# Stop all running containers
CONTAINERS=$(docker ps -q)
if [ -n "$CONTAINERS" ]; then
  echo "Stopping containers..."
  docker stop $CONTAINERS
fi

# Remove all containers
ALL_CONTAINERS=$(docker ps -aq)
if [ -n "$ALL_CONTAINERS" ]; then
  echo "Removing containers..."
  docker rm -f $ALL_CONTAINERS
fi

# Remove all images
IMAGES=$(docker images -q)
if [ -n "$IMAGES" ]; then
  echo "Removing images..."
  docker rmi -f $IMAGES
fi

# Remove all volumes
VOLUMES=$(docker volume ls -q)
if [ -n "$VOLUMES" ]; then
  echo "Removing volumes..."
  docker volume rm -f $VOLUMES
fi

# Remove all user-defined networks (not default ones)
NETWORKS=$(docker network ls -q | grep -v "$(docker network ls --filter 'name=bridge' -q)")
if [ -n "$NETWORKS" ]; then
  echo "Removing custom networks..."
  docker network rm $NETWORKS
fi

echo "Cleanup complete!"
