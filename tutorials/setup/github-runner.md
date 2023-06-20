# With Docker Swarm & Portainer

Follow the [setup tutorial for docker swarm](docker-swarm.md) if you haven't yet set up your environment.

For extended configuration options, have a look at the [Usage wiki](https://github.com/myoung34/docker-github-actions-runner/wiki/Usage) for the used docker image. You can infer variables from the docker compose or kubernetes setup.

## Image

`myoung34/github-runner`

## Volumes

Bind `/var/run/docker.sock` to `/var/run/docker.sock`

## Environment variables:
```
ORG_NAME={your_org}
RUNNER_TOKEN={your_token}
EPHEMERAL=1
RUNNER_NAME_PREFIX=github-runner
RUNNER_SCOPE=org
LABELS=linux,x64,swarm
```