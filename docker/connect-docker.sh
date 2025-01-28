#!/bin/bash

# Enable GUI
xhost +

# Check if the container is running
if [ "$(docker-compose ps | grep -q 'ros2ubuntu.*Up')" ]; then
    docker-compose exec ros2ubuntu bash
else
    echo "Starting the container..."
    docker-compose up -d
    docker-compose exec ros2ubuntu bash
fi
