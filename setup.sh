#!/bin/bash

# Update & install dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install -y x11vnc xvfb wget curl lxde

# Install Waydroid
echo "Installing Waydroid..."
sudo add-apt-repository ppa:waydroid-dev/waydroid -y
sudo apt update
sudo apt install -y waydroid

# Initialize Waydroid
echo "Initializing Waydroid..."
sudo waydroid init

# Start Waydroid container
echo "Starting Waydroid container..."
sudo systemctl start waydroid-container

# Launch Waydroid session
echo "Launching Waydroid session..."
waydroid session start &
sleep 10

# Start LXDE Desktop & VNC Server
echo "Starting VNC server..."
xvfb-run startlxde &
x11vnc -display :0 -forever -passwd android -create &

# Output VNC connection details
echo "VNC Server is running."
echo "Connect using: localhost:5900 with password 'android'"
