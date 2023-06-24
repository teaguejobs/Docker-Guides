Install Docker swarm on ubuntu using scripts

https://get.docker.com/


Docker Swarm | Summary and Commands
Docker Swarm | Summary and Commands

Great work on completing this section on Docker Swarm. In this section, we covered a handful of important concepts.

For one, we explored how with docker swarm we can have more than one machine running docker to achieve scalability and reliability. The swarm of docker-running machines implicitly sets up a fallback system where if one node goes down, another can serve customers in its place. Swarm itself also comes with built-in features such as the routing mesh and load balancing between nodes.

Finally, here’s the summary of commands that we’ve used so far. Head to the bottom of the summary to see new notes on Docker swarm.

Docker Containers

Create an interactive terminal container with a name, an image, and a default command:

Usage: docker create -it --name=<name> <image> <command>

Example: docker create -it --name=foo ubuntu bash

List all running containers:

docker container ls

(list all containers, running or not): docker container ls -a

Start a docker container:

Usage: docker start <container name/id>

Example: docker start foo

Attach to a docker container:

Usage: docker attach <container name/id>

Example: docker attach foo

Remove a container:

Usage: docker rm <container name/id>

Example: docker rm foo

Force remove: docker rm foo -f

Run a new container:

Usage: docker run <image> <command>

Example with options: docker run --name=bar -it ubuntu bash

Remove all containers:

docker container ls -aq | xargs docker container rm

Execute a command in a running container:

Usage: docker exec <container name/id> <command>

Example (interactive, with tty): docker exec -it express bash

Docker Images

Remove a docker image:

Usage: docker image rmi <image id>

Example (only uses first 3 characters of image id): docker rmi 70b

Remove all images:

docker image ls -aq | xargs docker rmi -f

Search for a docker image on dockerhub:

Usage: docker search <image>

Example: docker search ubuntu

List docker images:

docker image ls

Build a Docker image:

Usage: docker build <path>

Example (also tags and names the build): docker build . -t org/serve:0.0.0

Dockerfiles

Specify a base image:

Usage: FROM <base image>

Example: FROM node:latest

Set a working directory for the container:

Usage: WORKDIR <dir>

Example: WORKDIR /usr/src/app

Run a command for the container image:

Usage: RUN command

Command: RUN npm install -g serve

Copy files into the container:

Usage: COPY <local files/directories> <container files/directories>

Example: COPY ./display ./display

Inform that a port should be exposed

Usage: EXPOSE <port>

Example: EXPOSE 80

Specify a default command for the container:

Usage (shell format): CMD <default command>

Example: CMD serve ./display

Usage (exec format, recommended): CMD [“default command”, “arguments”]

Example: CMD [“node”, “server.js”]

Cross-Container Storage

Volumes

Create a volume

Usage: docker volume create <volume name>

Example: docker volume create shared-vol

Inspect a volume

Usage: docker volume inspect <volume name>

Example: docker volume inspect shared-vol

Mount a container with a volume using docker run

Usage: --mount source=<volume name>, target=<container dir>

Example:

docker run -it --name=foo --mount source=shared-vol,target=/src/shared ubuntu bash

Bind Mounts

Mount a container with a bind mount using docker run

Usage: --mount type=bind source=<host dir>, target=<container dir>

Example:

docker run -it --name=foo --mount type=bind source=/Users/foo/bindmountdir, \

target=/src/mountdir ubuntu bash

Tmpfs mounts

Mount a container with a tmpfs mount using docker run

Usage: --mount type=tmpfs, destination=<container dir>

Example:
docker run -it --name=baz --mount type=tmpfs, destination=/tmpdir ubuntu bash

Docker Networking

List docker networks

docker network ls

Inspect a docker network

Usage: docker network inspect <network name>

Example: docker network inspect bridge

Create a docker network

Usage: docker network create <network name>

Example: docker network create privatenw

Run a container with a custom docker network:

Usage: --network=<network name>

Example: docker run --network=privatenw -it --name=goo busybox

Docker Compose

Start a docker compose application

At the root (where docker-compose.yml is located): docker-compose up

Start a docker compose application and rebuild images:

Docker-compose up --build

docker-compose.yml

Version

Current version is 3. So at the top of the file, specify: version: ‘3’

Services with builds

Have a services key in the file. List out services one indent at a time.

Dependencies

Use the depends_on key and specify dependencies with a list. Each container dependency is marked by a dash, such as: -backend

Volumes

Have a volume key per service.

Connect a Docker host directory to a container directory, by joining them with a colon.

Example: ./dockerhostdir:/containerdir

Networks

Declare networks at the bottom of the file.

Specify each service’s network(s) with the networks option for each service.

Docker Swarm

Initialize a swarm in a node

Usage: docker swarm init --advertise-addr=<node ip>

Example: docker swarm init --advertise-addr=172.31.17.31

After initializing the swarm, you will find a join command for worker/other manager nodes

Example: docker swarm join --token SWMTKN-1-592fo0c31guwi9cw58jpaw89fafzyw5fzbk9dwiw8bm4xxpad-94vn587o9o3r73h3e5esujxm9 172.31.17.31:2377

List docker nodes from a manger:

docker node ls

Create a service for the swarm:

Usage: docker service create --name=<service name> --publish=<host port:service port> <service image>

Example: docker service create --name=site --publish=80:80 nginx

List services:

docker service ls

List the running tasks for a service:

Usage: docker service ps <service name>

Example: docker service ps site

Update a service

Usage: docker service update [options] <service name>

Example: docker service update --replicas=6 site