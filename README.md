# Jetson Nano with Ubuntu 20.04 Setup Guide

## Introduction

This guide provides a comprehensive, step-by-step instruction on setting up your Jetson Nano with Ubuntu 20.04. The guide covers the preparation, downloading and flashing of the image, and setting up Jetson Nano, along with troubleshooting tips and ROS2 installation.

## Step 1: Gather Your Tools

Before you begin, make sure you have the following items:

- **Jetson Nano board**
- **Minimum 32 GB microSD card** (recommended: 64 GB or larger for more space)
- **Card reader** (for flashing the image to the SD card)
- **Computer** (running Windows, macOS, or Linux)
- **Jetson Nano power supply** (5V 4A recommended)
- **Keyboard, mouse, HDMI monitor** (for setup)

## Step 2: Download the Image

### Download the Image File

Visit the link to download the **Jetson Nano Ubuntu 20.04 image** with pre-installed **OpenCV, TensorFlow, and PyTorch**. The file name is `JetsonNanoUb20_3b.img.xz` and it is **8.7 GB** in size.

- **Download Link**: Use either **Sync** or **Google Drive** options. Google Drive has daily download limits, so use it only if Sync is slow.
  - [GitHub Source](https://github.com/Qengineering/Jetson-Nano-Ubuntu-20-image)
  - [Sync Download Link](https://ln5.sync.com/dl/403a73c60/bqppm39m-mh4qippt-u5mhyyfi-nnma8c4t/view/default/14418794280004)
  - [Google Drive Link](https://drive.google.com/file/d/1L2H_sQC_kSILrcJteWg7htKxJirtDsZ9/view)

### Split Image Option (If Full Download Fails)

Due to the large size, you may prefer downloading the image in parts.

- **Split Files**: Download 14 smaller files named `JetsonNanoUb20_3b.img.xz.001`, `JetsonNanoUb20_3b.img.xz.002`, and so on.
- Once downloaded, place them in a single folder and run:
  ```
  7z x JetsonNanoUb20_3b.img.xz.001
  ```
  This will extract the entire image file automatically from all the parts.

## Step 3: Flash the Image to SD Card

### Prepare the SD Card

- Get a **32 GB or larger** SD card. A **64 GB** or larger card is recommended for extra working space.

### Flash the Image

- Use a tool like **Balena Etcher** or **Raspberry Pi Imager** to flash the `.img.xz` file directly onto the SD card.
  - [Download Balena Etcher](https://etcher.balena.io/#download-etcher)
- Note: Do **not unzip** the `.img.xz` file. Flash it as is.

## Step 4: Set Up Jetson Nano

### Insert the SD Card

Insert the flashed SD card into the **Jetson Nano**.

### Connect Accessories

Attach your **keyboard**, **mouse**, and **HDMI monitor**.

### Power Up

Plug in your power supply and wait for the Nano to boot up. The default username and password are both set to **jetson**.

## Step 5: Expand the Partition (Optional but Recommended)

After booting, your SD card's storage may be nearly full because of all the pre-installed software.

### Install GParted

Open a terminal and run:

```
sudo apt-get install gparted
```

### Resize the Partition

Launch **GParted** and use it to extend the main partition to the full size of your SD card (recommended if you used a 64 GB or larger card).

## Step 6: WiFi Setup

If you plan on using WiFi, connect your WiFi adapter to one of the USB ports and follow the standard Ubuntu process to connect to your wireless network.

## Step 7: Pre-installed Software

This image comes pre-installed with the following tools:

- **OpenCV 4.8.0**: For computer vision tasks
- **TensorFlow 2.4.1**: For deep learning
- **PyTorch 1.13.0** and **TorchVision 0.14.0**: For neural network applications
- **TensorRT 8.0.1.6**: Optimizing deep learning inference
- **TeamViewer** and **Jtop**: For remote control and system monitoring

## Step 8: Tips for Beginners

### First-Time Internet Connection

When connecting to the internet for the first time, allow **Software Updater** to complete updates for your system to ensure all components are up-to-date.

### Avoid Chromium

The **Chromium** browser can interfere with some system processes. Instead, use the pre-installed **Firefox** browser.

### Handle Storage Wisely

The SD card comes filled with software (around **21 GB**). Ensure you use at least a **64 GB** card for additional storage space during your projects.

## Step 9: Troubleshooting

### Corrupted Vulkan Warning

You might see a Vulkan-related error message during boot. To resolve it, remove the Vulkan folder:

```
sudo rm -rf /usr/share/vulkan/icd.d
```

### Memory Issues with OpenCV and TensorFlow

If importing **OpenCV** and **TensorFlow** throws an error related to memory allocation, import OpenCV first in your Python scripts.

### Upgrade Conflicts

If an upgrade fails due to a conflicting `sleep.conf` file, follow the instructions on the linked webpage for resolution.

## Optional: Headless Setup

If you wish to set up your Jetson Nano without a monitor (headless mode):

Run the following commands to remove the desktop environment:

```
sudo apt purge ubuntu-desktop -y && sudo apt autoremove -y && sudo apt autoclean
sudo apt-get remove snapd lightdm cups chromium*
```

This will reduce the memory footprint to around **420 MB**.

## ROS2 Setup

If you want to work with **ROS** (Robot Operating System), please refer to **JetsonNano-ROS2**. The provided image should be compatible.

## JetsonNano-ROS2 Guide

A comprehensive guide on setting up Jetson Nano with **ROS2**:

### Setup

Jetson Nano can be generally powered from a micro USB power supply (**5V 2A 10W max**). This can manage a keyboard, a mouse, and a small camera. If the planned use case for Jetson Nano is to run Neural Networks along with Depth cameras, it is better to power the device via the **DC barrel jack (5V 4A 20W max)**.

The **system setup comparison section** contains various combinations of **Ubuntu and ROS2** that were tested with and without GUI, and with and without Docker. The main purpose was to identify the stable combination that allows for the latest ROS version to be used as well as get the maximum output from the Jetson Nano.

### Recommended Installation

Follow the guidelines in **Install Docker engine** to update the preinstalled Docker version.
- [Install Docker Engine](https://docs.docker.com/engine/install/ubuntu/)

## Additional Resources

For further assistance, visit the official documentation page: [Install Ubuntu 20.04 on Jetson Nano](https://qengineering.eu/install-ubuntu-20.04-on-jetson-nano.html).

### Useful Links

- [GitHub Source](https://github.com/Qengineering/Jetson-Nano-Ubuntu-20-image)
- [Sync Download Link](https://ln5.sync.com/dl/403a73c60/bqppm39m-mh4qippt-u5mhyyfi-nnma8c4t/view/default/14418794280004)
- [Google Drive Link](https://drive.google.com/file/d/1L2H_sQC_kSILrcJteWg7htKxJirtDsZ9/view)
- [Download Balena Etcher](https://etcher.balena.io/#download-etcher)
- [Install Docker Engine](https://docs.docker.com/engine/install/ubuntu/)