#!/bin/sh

# https://docs.docker.com/engine/install/linux-postinstall/

# Create docker group
sudo groupadd docker

# Add self to docker group
sudo usermod -aG docker $USER

# Activate changes
newgrp docker

# Test without sudo
docker run hello-world

# Run on start
sudo systemctl enable docker.service
sudo systemctl enable containerd.service