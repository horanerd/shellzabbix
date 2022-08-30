#!/usr/bin/env bash
# 
# ----------------------------------------------------------------#
# Script Name:   "zabbix_agent_install.sh"
# Description:   Install zabbix agent in Linux servers (CentOS).
# Site:          https://medium.com/@amaurybsouza
# Written by:    Amaury Souza
# Maintenance:   Amaury Souza
# ----------------------------------------------------------------#
# Usage:         
#       $ ./zabbix_agent_install.sh
# ----------------------------------------------------------------#
# Bash Version:  
#              Bash 4.4.19
# ----------------------------------------------------------------#
# History:        v1.0 18/02/2019, Amaury:
#                - Start de program
#                - Add (wget) command
#                 v1.1 19/02/2019, Amaury:
#                - Tested using yum
#                 v1.2 20/02/2019, Amaury:
#                - Add #UserParameter=
# ----------------------------------------------------------------#
# Thankfulness: My team
#
# ----------------------------------------------------------------#
#Server data
echo -n "Digite o nome do seu Hostname: "
read hostname
echo -n "Digite o endereço IP Zabbix Server: "
read server
#Install zabbix agent
yum install -y wget
wget https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
rpm -i zabbix-release-4.0-1.el7.noarch.rpm
yum install -y zabbix-agent
#Configuration
echo "
PidFile=/var/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix/zabbix_agentd.log
LogFileSize=20
Include=/etc/zabbix/zabbix_agentd.d/
Hostname=$hostname
EnableRemoteCommands=1
LogRemoteCommands=1
Server=$server
ServerActive=$server
# UserParameter=
RefreshActiveChecks=120
ListenPort=10050
StartAgents=10
Timeout=3
DebugLevel=3
" > /etc/zabbix/zabbix_agentd.conf
#Start service zabbix agent
systemctl start zabbix-agent
systemctl enable zabbix-agent
exit