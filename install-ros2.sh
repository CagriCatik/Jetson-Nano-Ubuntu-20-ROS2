#!/bin/bash

# Constants
ROS_VERSION="foxy"  # Change this to install a different version (e.g., "humble" for Ubuntu 22.04)
UBUNTU_VERSION=$(lsb_release -cs)  # Detects the Ubuntu codename
WORKSPACE_DIR=~/ros2_ws

# Function to log messages
log() {
    echo -e "\e[32m$1\e[0m"
}

# Function to handle errors
handle_error() {
    log "Error occurred at line $1 while executing command: $2"
    exit 1
}

# Trap errors and report them
trap 'handle_error $LINENO "$BASH_COMMAND"' ERR

# Function to install necessary tools and ROS 2 packages
install_ros2() {
    log "Updating package index..."
    sudo apt update -y

    log "Installing curl if not installed..."
    sudo apt install curl -y

    log "Adding ROS 2 GPG key..."
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

    log "Adding ROS 2 repository to sources.list..."
    sudo sh -c "echo 'deb [arch=amd64,arm64,armhf] http://packages.ros.org/ros2/ubuntu $UBUNTU_VERSION main' > /etc/apt/sources.list.d/ros2-latest.list"

    log "Updating package index after adding ROS 2 repository..."
    sudo apt update -y

    log "Installing development tools and ROS dependencies..."
    sudo apt install -y \
        build-essential \
        cmake \
        git \
        python3-colcon-common-extensions \
        python3-pip \
        python3-rosdep \
        python3-vcstool \
        wget

    log "Installing ROS 2 $ROS_VERSION desktop..."
    sudo apt install ros-$ROS_VERSION-desktop -y

    log "Initializing rosdep..."
    sudo rosdep init || log "rosdep already initialized, skipping."
    rosdep update

    log "Sourcing ROS 2 $ROS_VERSION in bashrc..."
    grep -qxF "source /opt/ros/$ROS_VERSION/setup.bash" ~/.bashrc || echo "source /opt/ros/$ROS_VERSION/setup.bash" >> ~/.bashrc
    source ~/.bashrc

    log "Installing additional RMW implementations..."
    sudo apt install -y ros-$ROS_VERSION-rmw-fastrtps-cpp ros-$ROS_VERSION-rmw-cyclonedds-cpp

    log "Installing commonly used ROS 2 packages..."
    sudo apt install -y ros-$ROS_VERSION-demo-nodes-cpp ros-$ROS_VERSION-demo-nodes-py
}

# Function to set up a colcon workspace
setup_colcon_workspace() {
    log "Setting up colcon workspace at $WORKSPACE_DIR..."
    mkdir -p $WORKSPACE_DIR/src
    cd $WORKSPACE_DIR
    colcon build || log "Colcon workspace setup failed."
}

# Main script execution
log "Starting ROS 2 $ROS_VERSION installation on Ubuntu $UBUNTU_VERSION..."

install_ros2
setup_colcon_workspace

log "ROS 2 $ROS_VERSION installation complete."