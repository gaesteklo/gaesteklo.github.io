#!/bin/bash

# Install docker
hasCurl=$(which curl)

if [ ! -z "${hasCurl}" ] 
then
  bash <(curl -fsSL https://get.docker.com -o get-docker.sh)
else
  wget -q -O - https://get.docker.com -o get-docker.sh | bash
fi

docker swarm init

docker network create \
--driver overlay \
  portainer_agent_network
  
docker service create \
  --name portainer_agent \
  --network portainer_agent_network \
  --publish mode=host,target=9001,published=9001,protocol=tcp \
  --mode global \
  --constraint 'node.platform.os == linux' \
  --mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock \
  --mount type=bind,src=//var/lib/docker/volumes,dst=/var/lib/docker/volumes \
  portainer/agent:latest
