#!/bin/bash
# Script d'installation de l'agent Zabbix pour Ubuntu 24.04
# Auteur: Elmahdi Elbatir

set -e

# Variables - À modifier selon votre configuration
ZABBIX_SERVER_IP="10.0.1.252"
AGENT_HOSTNAME="Client-Linux"

echo "=== Téléchargement du dépôt Zabbix ==="
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-6+ubuntu24.04_all.deb

echo "=== Installation du dépôt ==="
sudo dpkg -i zabbix-release_6.0-6+ubuntu24.04_all.deb
sudo apt update

echo "=== Installation de l'agent Zabbix ==="
sudo apt install zabbix-agent -y

echo "=== Configuration de l'agent ==="
sudo sed -i "s/Server=127.0.0.1/Server=$ZABBIX_SERVER_IP/" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/ServerActive=127.0.0.1/ServerActive=$ZABBIX_SERVER_IP/" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/Hostname=Zabbix server/Hostname=$AGENT_HOSTNAME/" /etc/zabbix/zabbix_agentd.conf

echo "=== Démarrage du service ==="
sudo systemctl restart zabbix-agent
sudo systemctl enable zabbix-agent

echo "=== Vérification du statut ==="
sudo systemctl status zabbix-agent

echo "=== Installation terminée ==="
echo "L'agent Zabbix est configuré pour communiquer avec: $ZABBIX_SERVER_IP"

# Nettoyage
rm -f zabbix-release_6.0-6+ubuntu24.04_all.deb
