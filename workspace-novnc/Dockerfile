FROM katorlys/workspace-base:latest

# Run as root
USER root

# Install VNC and XFCE
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    tigervnc-standalone-server \
    tigervnc-common \
    dbus-x11 \
    xfce4 \
    xfce4-goodies \
    xfce4-terminal \
    xfonts-base \
    x11-xserver-utils \
    xdg-utils \
    # Basic GUI applications
    thunar \
    ristretto && \
    # Clean up installation cache
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Firefox
RUN add-apt-repository -y ppa:mozillateam/ppa && \
    echo -e 'Package: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001' > /etc/apt/preferences.d/mozilla-firefox && \
    apt-get update && \
    apt-get install -y --no-install-recommends firefox && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    # Set as default browser
    update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/firefox 200 && \
    update-alternatives --install /usr/bin/gnome-www-browser gnome-www-browser /usr/bin/firefox 200

# Install noVNC & websockify
RUN git clone --depth 1 https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone --depth 1 https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    # Enable users to enter noVNC upon visiting port
    ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

# Copy VNC startup scripts
COPY setup_vnc.sh /setup_vnc.sh
COPY start_vnc.sh /start_vnc.sh
RUN chmod +x /setup_vnc.sh /start_vnc.sh

# Set to `dev` user
USER dev

# Configure VNC
RUN /setup_vnc.sh
EXPOSE 6081

# Start desktop environment
CMD ["sh", "-c", "dbus-launch --exit-with-session /start_vnc.sh"]
