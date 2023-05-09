

```bash
apt update -y && apt upgrade -y
apt install -y apt-transport-https software-properties-common wget gnupg2
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
