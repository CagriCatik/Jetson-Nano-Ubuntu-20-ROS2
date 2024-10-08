#!/bin/bash

# Script to install Balena Etcher on Debian-based distributions

# Update package list
echo "Updating package list..."
sudo apt update

# Install necessary dependencies
echo "Installing necessary dependencies..."
sudo apt install -y curl gpg

# Download and add Etcher's GPG key
echo "Adding Balena Etcher GPG key..."
curl -1sLf 'https://dl.cloudsmith.io/public/balena/etcher/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/balena-etcher-archive-keyring.gpg

# Add the Etcher repository to your sources list
echo "Adding Balena Etcher repository..."
echo "deb [signed-by=/usr/share/keyrings/balena-etcher-archive-keyring.gpg] https://dl.cloudsmith.io/public/balena/etcher/deb/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/balena-etcher.list

# Update the package list to include the new repository
echo "Updating package list with the new repository..."
sudo apt update

# Install Balena Etcher
echo "Installing Balena Etcher..."
sudo apt install -y balena-etcher-electron

# Confirm installation
echo "Balena Etcher installation complete!"
balena-etcher-electron --version
