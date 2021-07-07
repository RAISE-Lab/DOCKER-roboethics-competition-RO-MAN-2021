#!/bin/bash
set -e
echo "Initializing competition workspace in /competition_ws"
if [ -d /competition_ws ]; then
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    echo -e "${RED}Competition workspace already exists, exiting${NC}"
    exit -1
fi

set -v
mkdir -p /competition_ws/src
git clone https://github.com/raise-lab/r2d2_competition /competition_ws/src/r2d2_competition
cd /competition_ws
catkin init
catkin build
echo "source /competition_ws/devel/setup.bash" >> /root/.bashrc
echo "Competition workspace successfull initialized"

