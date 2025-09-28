# DIUN Monitoring
See documentation here: https://crazymax.dev/diun/

Sends notifications for available updated container images.
Configured like this, it checks all containers running on the same docker host, regardless of set labels.
sThis example uses Telegram.

compose.yml

```yaml
name: diun
services:
  diun:
    image: crazymax/diun:latest
    command: serve
    hostname: ${HOSTNAME}
    volumes:
      - ./data:/data
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      TZ: Europe/Berlin
      DIUN_WATCH_WORKERS: 20
      DIUN_WATCH_SCHEDULE: 0 */6 * * *
      DIUN_WATCH_JITTER: 30s
      DIUN_PROVIDERS_DOCKER_WATCHBYDEFAULT: true
      DIUN_PROVIDERS_DOCKER: true
      DIUN_NOTIF_TELEGRAM_TOKEN: ${BOT_TOKEN}
      DIUN_NOTIF_TELEGRAM_CHATIDS: ${CHAT_ID}
      DIUN_NOTIF_TELEGRAM_DISABLENOTIFICATION: true
      # Custom template for Telegram notifications
      DIUN_NOTIF_TELEGRAM_TEMPLATEBODY: |
        *Diun Update on {{ .Meta.Hostname }}*  ^=^z

        A new image has been found for `{{ .Entry.Image }}`!

        Provider: `{{ .Entry.Provider }}`
        Status: `{{ .Entry.Status }}`
        Platform: `{{ .Entry.Manifest.Platform }}`
    restart: always
```

.env

```bash
HOSTNAME=<hostname> # only used in the notification template
BOT_TOKEN=<bot_token> # https://core.telegram.org/bots/tutorial#obtain-your-bot-token or https://gist.github.com/nafiesl/4ad622f344cd1dc3bb1ecbe468ff9f8a#create-a-telegram-bot-and-get-a-bot-token
CHAT_ID=<chat_id> # https://gist.github.com/nafiesl/4ad622f344cd1dc3bb1ecbe468ff9f8a#get-chat-id-for-a-private-chat
```