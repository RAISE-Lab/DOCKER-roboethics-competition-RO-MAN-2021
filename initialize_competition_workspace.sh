#!/bin/bash
set -e
set -v
echo "Initializing competition workspace in /competition_ws"
if [ -d /competition_ws ]; then
    echo "Competition workspace already exists, exiting"
    return
fi

mkdir -p /competition_ws/src
git clone https://github.com/raise-lab/r2d2_competition /competition_ws/src/r2d2_competition
cd /competition_ws
catkin init
catkin build
echo "source /competition_ws/devel/setup.bash" >> /root/.bashrc
echo "Competition workspace successfull initialized"

