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
ACCESS_TOKEN={your_token}
EPHEMERAL=1
RUNNER_NAME_PREFIX=github-runner
RUNNER_SCOPE=org
LABELS=linux,x64,swarm
```

### ACCESS_TOKEN

Is just a PAT (Personal Access Token) and needs the following permissions:
```
repo (all)
admin:org (all) (mandatory for organization-wide runner)
admin:enterprise (all) (mandatory for enterprise-wide runner)
admin:public_key - read:public_key
admin:repo_hook - read:repo_hook
admin:org_hook
notifications
workflow
```
You can create one [here](https://github.com/settings/tokens/new).

# Docker compose

```yml
version: '3.8'

services:
  github-runner:
    image: myoung34/github-runner:latest
    container_name: runner
    environment:
      - RUNNER_SCOPE=org
      - ORG_NAME=${ORG_NAME}
      - ACCESS_TOKEN=${ACCESS_TOKEN}
      - RUNNER_NAME=${RUNNER_NAME}
      - LABELS=linux,x64
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

```dotenv
ACCESS_TOKEN=ghp_yourtokentokentokentokentokentokento
ORG_NAME=your_org_name
RUNNER_NAME=your_runner_name
```
