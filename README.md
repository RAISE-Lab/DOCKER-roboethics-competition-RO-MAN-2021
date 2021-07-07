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


To be discueed:

### Collect & submit results
```
$ make pack
...
Generating notebook_export.tar.bz2
...
```
Submit the file `notebook_export.tar.bz2` in the current directory



## Docker build workflow
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

TODO: more documentation here

Please see the Makefile for all available options.

