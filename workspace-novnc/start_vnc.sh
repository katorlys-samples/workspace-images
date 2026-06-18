#!/bin/bash

start_vnc() {
    echo "Starting VNC on display :1..."
    vncserver :1 -geometry 1920x1080 -depth 24 -localhost=0 -SecurityTypes=None --I-KNOW-THIS-IS-INSECURE
    
    echo "Starting noVNC on port 6081..."
    /opt/noVNC/utils/websockify/run --web /opt/noVNC 6081 localhost:5901 &
    WEBSOCKIFY_PID=$!
}

stop_vnc() {
    echo "Stopping VNC..."
    vncserver -kill :1 2>/dev/null
    kill $WEBSOCKIFY_PID 2>/dev/null
}

trap stop_vnc SIGTERM SIGINT

# Start VNC & noVNC
start_vnc

# Keep the container running
wait $WEBSOCKIFY_PID
