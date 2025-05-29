# Watchtower Monitoring

compose.yml

```yaml
services:
  watchtower:
    image: containrrr/watchtower:latest
    container_name: watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - WATCHTOWER_LABEL_ENABLE=true
      - TZ=Europe/Berlin
      - WATCHTOWER_MONITOR_ONLY=true
      - WATCHTOWER_SCHEDULE=0 0 4 * * * # Run daily at 4:00 AM
      - WATCHTOWER_NOTIFICATIONS=shoutrrr
      - WATCHTOWER_NOTIFICATION_URL=telegram://${BOT_TOKEN}@telegram/?channels=${CHAT_ID}
    restart: unless-stopped
```

.env

```bash
BOT_TOKEN=<bot_token> # https://core.telegram.org/bots/tutorial#obtain-your-bot-token or https://gist.github.com/nafiesl/4ad622f344cd1dc3bb1ecbe468ff9f8a#create-a-telegram-bot-and-get-a-bot-token
CHAT_ID=<chat_id> # https://gist.github.com/nafiesl/4ad622f344cd1dc3bb1ecbe468ff9f8a#get-chat-id-for-a-private-chat
```

add label to existing compose.yml

```
version: '3.8'

services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
    labels:
      com.centurylinklabs.watchtower.enable: "true"

  db:
    image: postgres:13
    environment:
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypassword
    volumes:
      - ./db_data:/var/lib/postgresql/data
```