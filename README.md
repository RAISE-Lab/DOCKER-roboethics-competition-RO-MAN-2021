The docker build repository for the R2D2 competition


## Participant workflow
To initial start the simulation and programming environment
```
$ make run
echo "Starting competition container named r2d2_temp_awerner"
Starting competition container named r2d2_temp_awerner
docker run -it --net host --name r2d2_temp_awerner ghcr.io/raise-lab/r2d2_competition:latest
R2D2 Competition Docker Image
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

### To be discussed: Collect & submit results
```
$ make pack
...
Generating notebook_export.tar.bz2
...
```
Submit the file `notebook_export.tar.bz2` in the current directory


### To be tested: Update docker image
In case you need to update your docker image/container to a new version and want to keep your current notebook contents:
1. Run `make pack`, creating `notebook_export.tar.bz2`
2. Run `make pull`, updating the docker image
3. Run `make clean`, stopping the current container and deleting all modifications inside the container
4. Run `make run`, starting the new container
5. Run `make unpack`, copying your previous notebooks into the new container


### FAQ
1. `docker: Error response from daemon: Conflict. The container name "/r2d2_temp_..." is already in use by container ....`
The competition container is already running


## Competition team: Docker build workflow
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

