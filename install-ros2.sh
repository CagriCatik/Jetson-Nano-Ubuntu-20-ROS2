#!/bin/bash

# This script installs ROS 2 Humble Hawksbill on Ubuntu 22.04.

# Update package index
sudo apt update

# Install curl if not installed
sudo apt install curl -y

# Add the ROS 2 GPG key
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# Add the ROS 2 repository to sources.list
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# Update package index again after adding ROS 2 repository
sudo apt update

# Install development tools and ROS tools
sudo apt install -y \
    build-essential \
    cmake \
    git \
    python3-colcon-common-extensions \
    python3-pip \
    python3-rosdep \
    python3-vcstool \
    wget

# Install ROS 2 Humble desktop
sudo apt install ros-humble-desktop -y

# Initialize rosdep
sudo rosdep init
rosdep update

# Source ROS 2 setup.bash
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Install additional RMW implementations (optional, if needed)
sudo apt install ros-humble-rmw-fastrtps-cpp ros-humble-rmw-cyclonedds-cpp -y

# Install some commonly used ROS 2 packages
sudo apt install ros-humble-demo-nodes-cpp ros-humble-demo-nodes-py -y

# Set up colcon workspace (optional)
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws
colcon build

echo "ROS 2 Humble installation complete."
