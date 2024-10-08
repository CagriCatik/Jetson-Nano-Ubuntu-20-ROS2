# NoMachine Installation and Configuration on Jetson Nano

This guide will walk you through the process of installing and configuring NoMachine on a Jetson Nano for remote desktop access.

## Overview

NoMachine is a remote desktop application that allows you to access your Jetson Nano from another machine, such as a PC or mobile device. It supports multiple platforms, including Linux, Windows, macOS, and more.

This document provides instructions on installing NoMachine version `7.10.1_1` on a Jetson Nano using a `.zip` file that contains the `.deb` package.

## Prerequisites

- Jetson Nano running a supported Linux distribution
- Access to a terminal on the Jetson Nano (either directly or via SSH)
- Internet connection to download dependencies
- NoMachine `.zip` file: `Nomachine_7.10.1_1_arm64.zip`

## Step-by-Step Installation

### 1. Prepare the Installation Script

Ensure the installation script is executable by running the following command in your terminal:

```bash
chmod +x install_nomachine_from_zip.sh
```

### 2. Install NoMachine

Run the installation script by executing the following command in the terminal:

```bash
./install_nomachine_from_zip.sh
```

### 3. Verify the Installation

After the installation is complete, verify that NoMachine is installed by checking its version:

```bash
nomachine --version
```

If the version is displayed, NoMachine has been successfully installed.

## Configuring NoMachine

After installation, you can configure NoMachine with the following steps:

1. **Open NoMachine**:  
   On the Jetson Nano, launch NoMachine either from the desktop environment or by typing the following command in the terminal:

   ```bash
   nxplayer
   ```

2. **Accessing Jetson Nano Remotely**:
   - From another machine, install NoMachine from the official [NoMachine website](https://www.nomachine.com/download).
   - Open NoMachine on the client machine.
   - Create a new connection to the Jetson Nano using its IP address.

3. **Firewall and Network Configuration**:
   Ensure that port `4000` (default NoMachine port) is open on your network for external connections. If you're accessing the Jetson Nano over the internet, configure port forwarding accordingly.

## Uninstalling NoMachine

To uninstall NoMachine, you can run the following command:

```bash
sudo apt-get remove --purge nomachine
```

## Troubleshooting

- **Dependency Issues**:  
  If you encounter any dependency issues during installation, run the following command to resolve them:

  ```bash
  sudo apt-get install -f
  ```

- **Service Issues**:  
  If NoMachine is not working as expected, verify that the service is running with this command:

  ```bash
  sudo systemctl status nxserver
  ```

  If the service is not running, start it using:

  ```bash
  sudo systemctl start nxserver
  ```
