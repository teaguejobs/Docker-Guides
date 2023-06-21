Docker Compose in Depth - Volumes and Networks | Summary and Commands
Docker Compose in Depth | Volumes and Networks | Summary and Commands

Excellent work on completing this section on an even deeper dive into Docker compose. In this section, we covered Docker-compose volumes.

We used volumes creatively within the context of docker compose. Volumes are mainly reserved for creating a docker-host-managed directory for sharing files across containers. However, with volumes, we can set up automatic updating of docker-compose containers. By setting the volume to the source directory of the codebase, to the application-serving directory in the container, a live-updating setup can be achieved for docker-compose applications.

We also explored networking in our most ambitious compose application yet - using postgresql, node+express, flask, and php to create four services. The custom networks allow us to specifically connect services to each other, to create more privileged and secure access between containers in the applications.

Next, we’ll explore Docker swarm to explore Docker on more than one host. With more than one docker host, Docker will become even more powerful and exciting!

In the meantime, here’s the updated summary of commands that we’ve used so far:

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