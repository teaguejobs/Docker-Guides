Multicontainer Docker: Networking and Compose | Summary and Commands

Excellent work on completing this section on multi-container applications with docker. During this section, we covered a lot of very important ground with Docker, including docker’s networking features, as well as docker-compose.

With networking, we saw how more than one container can communicate in Docker. We have default networks to use in containers, such as the bridge network which allows us to immediately connect running containers. We can also set up private networks for a collection of containers. This private network even has its own embedded DNS server so that containers can connect by directly using container names.

We also worked with Docker Compose for the first time. Compose allows us to write the configuration for more than one container all at once. The group of containers created by compose makes up a multi-container application. Compose has a lot of features and benefits: it sets up a private network, and allows us to see the configuration for more than one of an application’s containers all at once.

Moving on, we’ll dive more deeply into compose, and see more advanced ways we can configure multi-container applications in Docker.

In the meantime, here’s a summary of the critical Docker commands we’ve used thus far:

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