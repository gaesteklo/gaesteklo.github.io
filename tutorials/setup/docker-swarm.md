# Setup docker swarm "manager"

First, [install docker](./docker.md) on the portainer server. This will be the "agent manager".

Then, run the following command, to enable swarm mode:
```bash
docker swarm init
```
This will run your current docker both as manager and worker node by default. You can connect other docker environments as workers (Documentation not written yet).

Then [install the portainer](./portainer.md).

# Setup portainer agent

Create the network:
```bash
docker network create \
--driver overlay \
  portainer_agent_network
```

Then create the service:
```bash
docker service create \
  --name portainer_agent \
  --network portainer_agent_network \
  --publish mode=host,target=9001,published=9001,protocol=tcp \
  --mode global \
  --constraint 'node.platform.os == linux' \
  --mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock \
  --mount type=bind,src=//var/lib/docker/volumes,dst=/var/lib/docker/volumes \
  portainer/agent:2.18.2
```
