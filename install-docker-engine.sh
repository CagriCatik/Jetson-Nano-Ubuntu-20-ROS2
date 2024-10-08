#!/bin/bash

# Uninstall old versions if they exist
sudo apt-get remove docker docker-engine docker.io containerd runc

# Update the apt package index
sudo apt-get update

# Install required packages
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the apt package index again with Docker's repo included
sudo apt-get update

# Install Docker Engine, CLI, and containerd
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Verify that Docker Engine is installed correctly
sudo docker run hello-world

# Optional: Add the current user to the Docker group so that you can run Docker commands without sudo
sudo usermod -aG docker $USER

echo "Docker installation complete. You may need to log out and log back in for the group changes to take effect."
