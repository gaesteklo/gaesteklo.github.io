# Docker compose

```yml
services:
  n8n:
    image: docker.n8n.io/n8nio/n8n
    restart: always
    ports:
      - 5678:5678
    environment:
      - N8N_HOST=${SUBDOMAIN}.${DOMAIN_NAME}
      - N8N_PORT=5678
      - N8N_PROTOCOL=https
      - NODE_ENV=production
      - WEBHOOK_URL=https://${SUBDOMAIN}.${DOMAIN_NAME}/
      - GENERIC_TIMEZONE=${GENERIC_TIMEZONE}
    volumes:
      - ${DATA_FOLDER}/.n8n:/home/node/.n8n
```

```dotenv
DOMAIN_NAME=example.com
SSL_EMAIL=mail@example.com
DATA_FOLDER=/home/user/docker_data/n8n
SUBDOMAIN=n8n
GENERIC_TIMEZONE=Europe/Berlin
```
