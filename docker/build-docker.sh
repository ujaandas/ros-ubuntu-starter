#!/bin/bash

# Create shared ros2 folder (files to be shared between container and host)
if [ ! -d "$HOME/$USER/fyp/shared/ros2" ]; then
  echo "CREATING $HOME/$USER/fyp/shared/ros2..."
  mkdir -p $HOME/$USER/fyp/shared/ros2
fi

# Build docker img
SCRIPT_PATH=$(dirname $(realpath "$0"))
PARENT_PATH=$(dirname "$SCRIPT_PATH")
sudo docker image build -f $SCRIPT_PATH/Dockerfile -t ros2ubuntu:latest $PARENT_PATH --no-cache