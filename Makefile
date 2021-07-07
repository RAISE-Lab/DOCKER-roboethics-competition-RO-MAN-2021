all: r2d2_competition

push: r2d2_competition_push

pull: r2d2_competition_pull

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

%_push: %
	docker push ghcr.io/raise-lab/$<:latest

%_pull:
	docker pull ghcr.io/raise-lab/$<:latest


%_promote:
	docker tag ghcr.io/raise-lab/$<:latest ghcr.io/raise-lab/$<:stable

update_base:
	docker pull palroboticssl/tiago_tutorials:melodic

r2d2_competition:
	docker build --network=host -t ghcr.io/raise-lab/$@:latest ${CURDIR}

