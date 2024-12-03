# Setup with Docker compose

It is recommended to check the `volumes` sections (there are two) and adjust them to your needs.

Version 12.0 guide: https://manual.seafile.com/12.0/setup/setup_ce_by_docker/#more-configuration-options

The guide also recommends spinning up a caddy container. This is not necessary if you use tools like Coolify. 

If you get a CSRF ERROR, do the following: https://github.com/haiwen/seafile/issues/2707#issuecomment-1732493096

```yml
services:
  db:
    image: '${SEAFILE_DB_IMAGE:-mariadb:10.11}'
    container_name: seafile-mysql
    environment:
      - 'MYSQL_ROOT_PASSWORD=${INIT_SEAFILE_MYSQL_ROOT_PASSWORD:?Variable is not set or empty}'
      - MYSQL_LOG_CONSOLE=true
      - MARIADB_AUTO_UPGRADE=1
    volumes:
      - '/mnt/seafile-volume/seafile-mysql:/var/lib/mysql'
    networks:
      - seafile-net
    healthcheck:
      test:
        - CMD
        - /usr/local/bin/healthcheck.sh
        - '--connect'
        - '--mariadbupgrade'
        - '--innodb_initialized'
      interval: 20s
      start_period: 30s
      timeout: 5s
      retries: 10
  memcached:
    image: '${SEAFILE_MEMCACHED_IMAGE:-memcached:1.6.29}'
    container_name: seafile-memcached
    entrypoint: 'memcached -m 256'
    networks:
      - seafile-net
  seafile:
    image: '${SEAFILE_IMAGE:-seafileltd/seafile-mc:12.0-latest}'
    container_name: seafile
    volumes:
      - '/mnt/seafile-volume/seafile-data:/shared'
    environment:
      - 'DEBUG=True'
      - 'DB_HOST=${SEAFILE_MYSQL_DB_HOST:-db}'
      - 'DB_PORT=${SEAFILE_MYSQL_DB_PORT:-3306}'
      - 'DB_ROOT_PASSWD=${INIT_SEAFILE_MYSQL_ROOT_PASSWORD:-}'
      - 'DB_PASSWORD=${SEAFILE_MYSQL_DB_PASSWORD:?Variable is not set or empty}'
      - 'SEAFILE_MYSQL_DB_CCNET_DB_NAME=${SEAFILE_MYSQL_DB_CCNET_DB_NAME:-ccnet_db}'
      - 'SEAFILE_MYSQL_DB_SEAFILE_DB_NAME=${SEAFILE_MYSQL_DB_SEAFILE_DB_NAME:-seafile_db}'
      - 'SEAFILE_MYSQL_DB_SEAHUB_DB_NAME=${SEAFILE_MYSQL_DB_SEAHUB_DB_NAME:-seahub_db}'
      - 'TIME_ZONE=${TIME_ZONE:-Etc/UTC}'
      - 'INIT_SEAFILE_ADMIN_EMAIL=${INIT_SEAFILE_ADMIN_EMAIL:-me@example.com}'
      - 'INIT_SEAFILE_ADMIN_PASSWORD=${INIT_SEAFILE_ADMIN_PASSWORD:-asecret}'
      - 'SEAFILE_SERVER_HOSTNAME=${SEAFILE_SERVER_HOSTNAME:?Variable is not set or empty}'
      - 'SEAFILE_SERVER_PROTOCOL=${SEAFILE_SERVER_PROTOCOL:-http}'
      - 'SITE_ROOT=${SITE_ROOT:-/}'
      - 'NON_ROOT=${NON_ROOT:-false}'
      - 'JWT_PRIVATE_KEY=${JWT_PRIVATE_KEY:?Variable is not set or empty}'
      - 'ENABLE_SEADOC=${ENABLE_SEADOC:-false}'
      - 'SEADOC_SERVER_URL=${SEADOC_SERVER_URL:-http://example.example.com/sdoc-server}'
    depends_on:
      - db
      - memcached
    networks:
      - seafile-net
networks:
  seafile-net:
    name: seafile-net
```

## Environment variables

Please note the `{GENERATE_THIS}` and `{YOUR_URL}` parts:

```dotenv
ENABLE_SEADOC=false
INIT_SEAFILE_ADMIN_EMAIL=my@mail.com
INIT_SEAFILE_ADMIN_PASSWORD={GENERATE_THIS}
INIT_SEAFILE_MYSQL_ROOT_PASSWORD={GENERATE_THIS}
JWT_PRIVATE_KEY={GENERATE_THIS}
NON_ROOT=false
SEADOC_SERVER_URL=https://{YOUR_DOMAIN}/sdoc-server
SEAFILE_MYSQL_DB_CCNET_DB_NAME=ccnet_db
SEAFILE_MYSQL_DB_HOST=db
SEAFILE_MYSQL_DB_PASSWORD={GENERATE_THIS}
SEAFILE_MYSQL_DB_PORT=3306
SEAFILE_MYSQL_DB_SEAFILE_DB_NAME=seafile_db
SEAFILE_MYSQL_DB_SEAHUB_DB_NAME=seahub_db
SEAFILE_SERVER_HOSTNAME={YOUR_DOMAIN}
SEAFILE_SERVER_PROTOCOL=http
SITE_ROOT=/
TIME_ZONE=Etc/UTC
```
