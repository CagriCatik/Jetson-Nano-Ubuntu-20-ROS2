#!/bin/bash

# Pi Imager Installer Script
# This script installs the Raspberry Pi Imager on a Debian-based Linux distribution.

# Function to print messages
function echo_message() {
    echo -e "\n\e[32m$1\e[0m\n"
}

# Update the system
echo_message "Updating the system..."
sudo apt update && sudo apt upgrade -y

# Install necessary dependencies
echo_message "Installing dependencies..."
sudo apt install -y wget software-properties-common apt-transport-https

# Download and add the Raspberry Pi GPG key
echo_message "Adding Raspberry Pi GPG key..."
wget -O - https://archive.raspberrypi.org/debian/raspberrypi.gpg.key | sudo tee /etc/apt/trusted.gpg.d/raspberrypi-archive.gpg.key > /dev/null

# Add Raspberry Pi repository to the system
echo_message "Adding Raspberry Pi repository..."
echo "deb https://archive.raspberrypi.org/debian/ buster main" | sudo tee /etc/apt/sources.list.d/raspi.list

# Update the package list
echo_message "Updating package list..."
sudo apt update

# Install Raspberry Pi Imager
echo_message "Installing Raspberry Pi Imager..."
sudo apt install -y rpi-imager

# Installation complete
echo_message "Installation complete! You can now run Raspberry Pi Imager by typing 'rpi-imager' in the terminal."
