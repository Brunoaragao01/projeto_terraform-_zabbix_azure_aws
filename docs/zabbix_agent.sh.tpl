#!/bin/bash
cd /tmp/
sudo https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_7.0-2+ubuntu24.04_all.deb
sudo apt update
sudo apt install zabbix-agent -y
sudo sed -i 's/ServerActive=.*/ServerActive=${zabbix_server_ip}/' /etc/zabbix/zabbix_agentd.conf
sudo sed -i 's/Server=.*/Server=${zabbix_server_ip}/' /etc/zabbix/zabbix_agentd.conf
sudo systemctl restart zabbix-agent
sudo systemctl enable zabbix-agent
