#! /bin/bash

cd /tmp
sudo wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_7.0-2+ubuntu24.04_all.deb
sudo apt update
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent mysql-server -y



sudo echo "create database ${NOME_BD_ZABBIX} character set utf8mb4 collate utf8mb4_bin;" >> /tmp/sql.txt
sudo echo "create user '${USUARIO_BD_ZABBIX}'@'${SERVER_BD_ZABBIX}' identified by '${SENHA_BD_ZABBIX}';" >> /tmp/sql.txt
sudo echo "grant all privileges on ${USUARIO_BD_ZABBIX}.* to '${NOME_BD_ZABBIX}'@'${SERVER_BD_ZABBIX}';" >> /tmp/sql.txt
sudo echo "set global log_bin_trust_function_creators = 1;" >> /tmp/sql.txt
sudo systemctl start mysql.service
sudo mysql < /tmp/sql.txt


sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -D${NOME_BD_ZABBIX} -u${USUARIO_BD_ZABBIX} -p${SENHA_BD_ZABBIX}


#sudo sed -i 's/DBUser=.*/DBUser=${USUARIO_BD_ZABBIX}/' /etc/zabbix/zabbix_server.conf
sudo sed -i 's/.*DBPassword=.*/DBPassword=${SENHA_BD_ZABBIX}/' /etc/zabbix/zabbix_server.conf
sudo sed -i 's/.*DBHost=.*/DBHost=${SERVER_BD_ZABBIX}/' /etc/zabbix/zabbix_server.conf
#sudo sed -i 's/.*DBName=.*/DBName=${NOME_BD_ZABBIX}/' /etc/zabbix/zabbix_server.conf
sudo sed -i 's/.*php_value date.timezone Europe.*/php_value date.timezone America\/Sao_Paulo/' /etc/zabbix/apache.conf

sudo systemctl restart zabbix-server zabbix-agent apache2 mysql.service
sudo systemctl enable zabbix-server zabbix-agent apache2 mysql.service













