FROM palroboticssl/tiago_tutorials:melodic

# setup entrypoint
COPY ./docker_entrypoint.sh /root

ENTRYPOINT ["/root/docker_entrypoint.sh"]

# Install Jupyter notebook
RUN apt install -q -y jupyter-notebook

COPY start_simulator.sh /usr/local/bin
COPY start_notebook_server.sh /usr/local/bin
COPY initialize_competition_workspace.sh /usr/local/bin

