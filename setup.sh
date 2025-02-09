#!/bin/bash

# Update system and install required packages
echo "Updating system..."
sudo apt update && sudo apt install -y xfce4 xfce4-goodies tightvncserver novnc websockify

# Set up VNC password
echo "Setting up VNC password..."
echo "vncpassword" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Configure VNC to use XFCE
echo "Configuring VNC..."
echo "#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Start VNC server
echo "Starting VNC server..."
vncserver :1 -geometry 1280x720 -depth 24

# Run NoVNC to access VNC in browser
echo "Starting NoVNC..."
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &

# Keep the session alive
echo "Setup complete! Access VNC at:"
echo "http://localhost:6080"
tmux new-session -d -s vnc 'while true; do sleep 1000; done'
