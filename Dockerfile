FROM palroboticssl/tiago_tutorials:melodic

# setup entrypoint
COPY ./docker_entrypoint.sh /root

ENTRYPOINT ["/root/docker_entrypoint.sh"]

# need to import new OSRF key for ROS packages as base image is stale
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key F42ED6FBAB17C654

# need to update package database as base image is stale
RUN apt update

# Install Jupyter notebook
RUN apt install -q -y jupyter-notebook python-jupyter-console python-jupyter-sphinx-theme less

# Following sections from icub-training docker
# See https://github.com/icub-training/icub-training.github.io/blob/master/dockerfiles/Dockerfile
# Install graphics
RUN DEBIAN_FRONTEND=noninteractive apt install -q -y xfce4 xfce4-goodies xserver-xorg-video-dummy xserver-xorg-legacy x11vnc && \
    sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
COPY xorg.conf /etc/X11/xorg.conf

# Install noVNC
RUN apt install net-tools && \
    git clone --depth=1 -b stable/v0.6 https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone --depth=1 https://github.com/novnc/websockify /opt/novnc/utils/websockify && \
    echo "<html><head><meta http-equiv=\"Refresh\" content=\"0; url=vnc.html?autoconnect=true&reconnect=true&reconnect_delay=1000&resize=scale&quality=9\"></head></html>" > /opt/novnc/index.html


COPY start_simulator.sh /usr/local/bin
COPY start_notebook_server.sh /usr/local/bin
COPY initialize_competition_workspace.sh /usr/local/bin

ENV DISPLAY=:1

