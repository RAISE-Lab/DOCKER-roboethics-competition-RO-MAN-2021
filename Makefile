all: roboethics_competition

push: roboethics_competition_push

push_stable:
	docker push ghcr.io/raise-lab/roboethics_competition:stable

pull: roboethics_competition_pull

promote: roboethics_competition_promote

run:
	echo "Starting competition container named roboethics_temp_${USER}"
	docker run -it --net host --name roboethics_temp_${USER} ghcr.io/raise-lab/roboethics_competition:latest

continue:
	echo "Continuing your session in the container named roboethics_temp_${USER}"
	docker start roboethics_temp_${USER}
	docker attach roboethics_temp_${USER}

clean:
	echo "Removing your container named roboethics_temp_${USER}"
	docker container rm roboethics_temp_${USER}

pack:
	echo "Extracting notebook folder for competition upload"
	rm -rf /tmp/notebook_export
	docker cp roboethics_temp_${USER}:/competition_ws/src/roboethics_competition/notebook /tmp/notebook_export
	test -f notebook_export.tar.bz2 && echo "\033[0;31mnotebook_export.tar.bz2 already exists, not overwriting it\033[0m" || echo "\033[0;32mGenerating notebook_export.tar.bz2\033[0m"
	test -f notebook_export.tar.bz2 || tar -C /tmp --exclude=.ipynb_checkpoints --exclude=nohup.out -jcf notebook_export.tar.bz2 notebook_export
	rm -rf /tmp/notebook_export

unpack:
	echo "Restoring the contents of notebook_export.tar.bz2 into the docker container"
	rm -rf /tmp/notebook_export
	tar -C /tmp -jxf notebook_export.tar.bz2
	ls -ld /tmp/notebook_export
	docker cp /tmp/notebook_export roboethics_temp_${USER}:/competition_ws/src/roboethics_competition/notebook
	rm -rf /tmp/notebook_export

%_push:
	docker push ghcr.io/raise-lab/$*:latest

%_pull:
	docker pull ghcr.io/raise-lab/$*:latest
	
%_promote:
	docker tag ghcr.io/raise-lab/$*:latest ghcr.io/raise-lab/$*:stable

update_base:
	docker pull palroboticssl/tiago_tutorials:melodic

roboethics_competition:
	docker build --network=host -t ghcr.io/raise-lab/$@:latest ${CURDIR}

