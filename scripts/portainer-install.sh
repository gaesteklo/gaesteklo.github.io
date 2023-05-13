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
tee -a docker-compose.yml << END
version: "3"
services:
  portainer:
    image: portainer/portainer-ce:latest
    ports:
      - 9443:9443
      volumes:
        - data:/data
        - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped
volumes:
  data:
END

# Start portainer
docker compose up -d
