# Install Portainer

In order to install portainer first [install docker](./docker.md).

Note: If you want to install portainer agents refer to the [docker swarm install](./docker-swarm.md).

Then create a `docker-compose.yml` with the following content:
```yml
version: "3.7"
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
```

For ease of use copy paste this command:

```bash
tee docker-compose.yml << END
version: "3.7"
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
```

Then run `docker compose up -d`. This will run the `docker-compose.yml` and updated all the containers if they are not up to date. 
So in order to update portainer just run `docker compose up -d` again.

Now you should be able to connect to the portainer with the specified port `http://<ip_of_you_server>:9000`. 
 
*NOTE: When first logging onto the page you have to set the admin password.*

To make it more easy for just run this command:

wget:
```bash
wget -q -O - https://raw.githubusercontent.com/gaesteklo/gaesteklo.github.io/main/scripts/portainer-install.sh | bash
```

curl:
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/gaesteklo/gaesteklo.github.io/main/scripts/portainer-install.sh)
```

This command will install docker and portainer all in one command.

    ATTENTION: Make sure what you are executing by looking at this file first. Don't just execute untrusted code!
