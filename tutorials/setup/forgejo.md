# Setup with Docker compose

This will set up a simple Forgejo instance, assuming that you'll use Sqlite for storing data. It won't use the Forgejo runner, since the Gitea runner is simpler to set up (or at least was more easy to figure out).

```yml
version: '3'

networks:
  forgejo:
    external: false

services:
  forgejo:
    image: codeberg.org/forgejo/forgejo:1.20
    container_name: forgejo
    environment:
      - USER_UID=1000
      - USER_GID=1000
      - FORGEJO__actions__ENABLED="true"
    restart: always
    networks:
      - forgejo
    volumes:
      - ./forgejo:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - '3002:3000'
      - '222:22'

  runner-daemon:
    image: gitea/act_runner:nightly
    environment:
      - GITEA_INSTANCE_URL=${GITEA_INSTANCE_URL}
      - GITEA_RUNNER_REGISTRATION_TOKEN=${GITEA_RUNNER_REGISTRATION_TOKEN}
    networks:
      - forgejo
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

## Environment variables

|name                           |value example                 |
|-------------------------------|------------------------------|
|GITEA_INSTANCE_URL             |https://forgejo.yourdomain.com|
|GITEA_RUNNER_REGISTRATION_TOKEN| // GET FROM /admin/actions/runners // |
