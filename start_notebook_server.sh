#!/bin/bash
echo "Starting jupyter notebook server"
set -e
if [ ! -f /competition_ws/devel/setup.bash ]; then
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    echo -e "${RED}Please initialize & build the competition workspace using initialize_competition_workspace.sh first${NC}"
    exit -1
fi
source /competition_ws/devel/setup.bash
set -v
NOTEBOOK_CODE=/competition_ws/src/r2d2_competition/notebook
cd ${NOTEBOOK_CODE}
nohup jupyter notebook -y --allow-root --no-browser --ip='localhost' --NotebookApp.token='' --NotebookApp.password='' --MappingKernelManager.default_kernel_name=python2 &
set +v
sleep 2
echo "Notebook server is now accessible at http://localhost:8888"
