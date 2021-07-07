all: r2d2_competition

push: r2d2_competition_push

push_stable:
	docker push ghcr.io/raise-lab/r2d2_competition:stable

pull: r2d2_competition_pull

promote: r2d2_competition_promote

run:
	echo "Starting competition container named r2d2_temp_${USER}"
	docker run -it --net host --name r2d2_temp_${USER} ghcr.io/raise-lab/r2d2_competition:latest

continue:
	echo "Continuing your session in the container named r2d2_temp_${USER}"
	docker start r2d2_temp_${USER}
	docker attach r2d2_temp_${USER}

clean:
	echo "Removing your container named r2d2_temp_${USER}"
	docker container rm r2d2_temp_${USER}

pack:
	echo "Extracting notebook folder for competition upload"
	rm -rf /tmp/notebook_export
	docker cp r2d2_temp_${USER}:/competition_ws/src/r2d2_competition/notebook /tmp/notebook_export
	test -f notebook_export.tar.bz2 && echo "\033[0;31mnotebook_export.tar.bz2 already exists, not overwriting it\033[0m" || echo "\033[0;32mGenerating notebook_export.tar.bz2\033[0m"
	test -f notebook_export.tar.bz2 || tar -C /tmp --exclude=.ipynb_checkpoints --exclude=nohup.out -jcf notebook_export.tar.bz2 notebook_export
	rm -rf /tmp/notebook_export

unpack:
	echo "Restoring the contents of notebook_export.tar.bz2 into the docker container"
	rm -rf /tmp/notebook_export
	tar -C /tmp -jxf notebook_export.tar.bz2
	ls -ld /tmp/notebook_export
	docker cp /tmp/notebook_export r2d2_temp_${USER}:/competition_ws/src/r2d2_competition/notebook
	rm -rf /tmp/notebook_export

%_push:
	docker push ghcr.io/raise-lab/$*:latest

%_pull:
	docker pull ghcr.io/raise-lab/$*:latest
	
%_promote:
	docker tag ghcr.io/raise-lab/$*:latest ghcr.io/raise-lab/$*:stable

update_base:
	docker pull palroboticssl/tiago_tutorials:melodic

r2d2_competition:
	docker build --network=host -t ghcr.io/raise-lab/$@:latest ${CURDIR}

