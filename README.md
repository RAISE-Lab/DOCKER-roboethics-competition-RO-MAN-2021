The docker build repository for the Roboethics competition

## Workflow for Participants
To initial start the simulation and programming environment
```
$ make run
echo "Starting competition container named roboethics_temp_awerner"
Starting competition container named roboethics_temp_awerner
docker run -it --net host --name roboethics_temp_awerner ghcr.io/raise-lab/roboethics_competition:latest
Roboethics Competition Docker Image
If you close this window, all applications in the docker will be terminated
root@robotlab-lt1:/tiago_public_ws# initialize_competition_workspace.sh
...
Competition workspace successfull initialized
root@robotlab-lt1:/tiago_public_ws# start_simulator.sh 
...
Simulation started successfully, access it with your web browser via http://localhost:6080
root@robotlab-lt1:/tiago_public_ws# start_notebook_server.sh
...
Notebook server is now accessible at http://localhost:8888/tree?
```
- The robot inside the simulation is available through the link http://localhost:6080 
- The competition tutorials can be accessed through the link http://localhost:8888

To stop working, just close the shell/stop the docker container.

To resume work, run
```
$ make continue
...
root@robotlab-lt1:/tiago_public_ws# start_simulator.sh 
...
Simulation started successfully, access it with your web browser via http://localhost:6080
root@robotlab-lt1:/tiago_public_ws# start_notebook_server.sh
...
Notebook server is now accessible at http://localhost:8888/tree?
```

### Submission Guidelines
Please find all information for submitting your designs on our [competition website](https://competition.raiselab.ca/participants/submission-guidelines).


### To be tested: Update docker image
In case you need to update your docker image/container to a new version and want to keep your current notebook contents:
1. Run `make pack`, creating `notebook_export.tar.bz2`
2. Run `make pull`, updating the docker image
3. Run `make clean`, stopping the current container and deleting all modifications inside the container
4. Run `make run`, starting the new container
5. Run `make unpack`, copying your previous notebooks into the new container


### FAQ
#### `docker: Error response from daemon: Conflict. The container name "/roboethics_temp_..." is already in use by container ....`
The competition container is already running, you can remove it with `make clean`.

#### I think i am triggering a bug in Gazebo, were is the log file?
It's located in `/tmp/ros.log`

#### Can I develop without the docker/software-rendering/jupyter-notebook
Yes. But then you are a bit on your own. And finally things will have to run in this docker.
You can use http://wiki.ros.org/Robots/TIAGo/Tutorials/Installation/TiagoSimulation as a starting point for your setup.

#### Gazebo has crashed, how do I restart it?
```
killall roslaunch
```
To restart run
```
source /competition_ws/devel/setup.bash
roslaunch roboethics_competition_api simulation.launch
```
#### How can i start the docker using my native GPU

See [ROS Documentation](http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration) for support on a per-vendor basis.

Below is a quickstart guide for Intel GPUs:

Before running `make run`, use
```
export DOCKER_OPTIONS="--env DISPLAY --ipc=host --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw --device /dev/dri:/dev/dri -p 6080:6080 -p 8888:8888 --gpus=all"
```
If you are using a Nvidia GPU, additionally run this
```
make roboethics_competition_nvidia
export IMAGE_SUFFIX=:nvidia
```

then to run the simulation instead of `start_simulator.sh`
```
cd /competiton_ws
source devel/setup.bash
roslaunch roboethics_competition_api simulation.launch
```

## Information for Organizing Team
Ignore this section if you are a participant.
### Evaluation & video recording workflow
For video recording the whole screen needs to be captured. For this a tool like ffmpeg or vokoscreen can be used. It can be started from python. The disadvantage is the non-determinism because the execution time is cpu-load dependant. Using a video camera output of gazebo, and further processing could help.

### Docker build workflow
1. Build docker image as tag `latest`
```
$ make
....
```
2. Upload created docker image with the tag `latest` to github package registry
```
$ make push
```
3. Promote tag `latest` to tag `stable`
```
$ make promote
```
2. Upload created docker image with the tag `stable` to github package registry
```
$ make push_table
```
Please see the Makefile for all available options.

### FAQ
#### Docker registry login:
1. generate personal access token:
github user profile -> developer settings -> personal access token -> activate write:packages -> generate token
2. login
```
echo access_token | | docker login ghcr.io -u github_user_name --password-stdin
```
#### Edit competition.yaml in a graphical editor
Run this:
```
leafpad /competition_ws/src/roboethics_competition/roboethics_competition_api/config/competition.yaml
```


