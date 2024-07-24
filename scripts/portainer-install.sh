#!/bin/bash

# Install docker
hasCurl=$(which curl)

if [ ! -z "${hasCurl}" ] 
then
  bash <(curl -fsSL https://get.docker.com -o get-docker.sh)
else
  wget -q -O - https://get.docker.com -o get-docker.sh | bash
fi


# Prepare docker compose for portainer
tee docker-compose.yml << END
services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    command: -H unix:///var/run/docker.sock
    ports:
      - "9000:9000"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
      - "portainer_data:/data"
    restart: always

volumes:
  portainer_data:
END

# Start portainer
docker compose up -d
