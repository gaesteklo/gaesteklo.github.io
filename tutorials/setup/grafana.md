# Grafana

To set up grafana, we will use the official grafana docker image. We will also use a docker volume to store the data and configuration files.

```bash
apt update -y && apt upgrade -y
apt install -y apt-transport-https
apt install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
apt install gnupg2
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
echo "deb https://packages.grafana.com/enterprise/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list
apt update -y
apt install grafana-enterprise
systemctl daemon-reload
systemctl enable grafana-server.service
nano /etc/grafana/grafana.ini
mkdir /grafana/data
mkdir /grafana/logs
mkdir /grafana/plugins
systemctl restart grafana-server
chown -R grafana:grafana /grafana/
```
