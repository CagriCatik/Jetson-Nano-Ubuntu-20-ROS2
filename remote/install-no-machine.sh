#!/bin/bash

# Define the filename
NOMACHINE_ZIP="Nomachine_7.10.1_1_arm64.zip"
NOMACHINE_DEB="nomachine_7.10.1_1_arm64.deb"

# Check if the zip file exists
if [[ ! -f "$NOMACHINE_ZIP" ]]; then
    echo "Error: $NOMACHINE_ZIP not found. Please place the zip file in the current directory."
    exit 1
fi

# Unzip the file
echo "Unzipping $NOMACHINE_ZIP..."
unzip ${NOMACHINE_ZIP}

# Verify that the .deb file exists after unzipping
if [[ ! -f "$NOMACHINE_DEB" ]]; then
    echo "Error: $NOMACHINE_DEB not found after unzipping."
    exit 1
fi

# Install the .deb package
echo "Installing NoMachine..."
sudo dpkg -i ${NOMACHINE_DEB}

# Fix missing dependencies, if any
echo "Fixing missing dependencies..."
sudo apt-get install -f -y

# Confirm successful installation
if nomachine --version; then
    echo "NoMachine installed successfully!"
else
    echo "NoMachine installation failed."
fi
