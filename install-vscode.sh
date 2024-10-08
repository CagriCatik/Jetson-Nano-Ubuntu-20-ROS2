#!/bin/bash

# Script to install Visual Studio Code on ARM64 architecture (Jetson, Raspberry Pi, etc.)
# Define the version of Visual Studio Code to install. 'latest' will install the latest stable release.
VERSION=latest

# Log file for the installation process
LOG_FILE="vscode_install.log"

echo "Starting Visual Studio Code installation..." | tee -a $LOG_FILE

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (or use sudo)" | tee -a $LOG_FILE
  exit 1
fi

# Update the package list and install prerequisites for .deb packages
echo "Updating package list and installing prerequisites..." | tee -a $LOG_FILE
sudo apt update | tee -a $LOG_FILE
sudo apt install -y wget gdebi-core | tee -a $LOG_FILE

# Download the Visual Studio Code .deb package for ARM64 architecture
echo "Downloading Visual Studio Code version: $VERSION..." | tee -a $LOG_FILE
wget -N -O vscode-linux-deb.arm64.deb "https://update.code.visualstudio.com/$VERSION/linux-deb-arm64/stable" 2>> $LOG_FILE

# Check if the download was successful
if [ $? -ne 0 ]; then
  echo "Error downloading Visual Studio Code. Please check your network or the URL." | tee -a $LOG_FILE
  exit 1
else
  echo "Download completed successfully." | tee -a $LOG_FILE
fi

# Install the package using apt or gdebi (to handle dependencies properly)
echo "Installing Visual Studio Code..." | tee -a $LOG_FILE
sudo apt install -y ./vscode-linux-deb.arm64.deb 2>> $LOG_FILE

# Check if the installation was successful
if [ $? -ne 0 ]; then
  echo "Error installing Visual Studio Code. Please check the log for details." | tee -a $LOG_FILE
  exit 1
else
  echo "Visual Studio Code installed successfully." | tee -a $LOG_FILE
fi

# Clean up the downloaded .deb package
echo "Cleaning up downloaded .deb file..." | tee -a $LOG_FILE
rm vscode-linux-deb.arm64.deb

# Optional: Check if Visual Studio Code is installed successfully and print the version
echo "Verifying Visual Studio Code installation..." | tee -a $LOG_FILE
if command -v code >/dev/null 2>&1; then
  echo "Visual Studio Code installed. Version information:" | tee -a $LOG_FILE
  code --version | tee -a $LOG_FILE
else
  echo "Visual Studio Code was not installed correctly. Please check the log for errors." | tee -a $LOG_FILE
  exit 1
fi

echo "Installation complete. Check the log at $LOG_FILE for details."
