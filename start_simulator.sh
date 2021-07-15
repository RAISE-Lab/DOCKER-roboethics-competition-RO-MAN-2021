#!/bin/bash
echo "Starting gazebo simulating"
set -e
if [ ! -f /competition_ws/devel/setup.bash ]; then
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    echo -e "${RED}Please initialize & build the competition workspace using initialize_competition_workspace.sh first${NC}"
    exit -1
fi
source /competition_ws/devel/setup.bash
set -v
cd /competition_ws/

# Start X11 / VNC server 

# from icub-training docker
# https://github.com/icub-training/icub-training.github.io/blob/master/dockerfiles/start-vnc-session.sh
pkill -9 -f "vnc" && pkill -9 -f "xf" && sudo pkill -9 Xorg
rm -f /tmp/.X1-lock
nohup X ${DISPLAY} -config /etc/X11/xorg.conf > /tmp/xorg.log 2>&1 &
nohup startxfce4 > /dev/null 2>&1 &
nohup x11vnc -localhost -display ${DISPLAY} -N -forever -shared -bg > /tmp/x11vnc.log 2>&1
nohup /opt/novnc/utils/launch.sh --web /opt/novnc --vnc localhost:5901 --listen 6080 > /tmp/novnc.log 2>&1 &

sleep 1

set +v
# Launch simulation
nohup roslaunch roboethics_competition_api simulation.launch > /tmp/ros.log 2>&1 &
#roslaunch roboethics_competition simulator.launch

#sleep 2
echo "Simulation started successfully, access it with your web browser via http://localhost:6080"
echo "Alternatively you can use a vnc client and connect to vnc://localhost:1"
echo "To interact with the simulation, you can start the notebook server using start_notebook_server.sh"
