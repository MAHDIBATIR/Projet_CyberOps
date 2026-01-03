#!/bin/bash
# Script d'installation de Docker pour Ubuntu 24.04
# Auteur: Elmahdi Elbatir

set -e

echo "=== Mise à jour du système ==="
sudo apt update && sudo apt upgrade -y

echo "=== Installation de Docker ==="
sudo apt install -y docker.io docker-compose

echo "=== Configuration de l'utilisateur ==="
sudo usermod -aG docker $USER

echo "=== Activation de Docker ==="
sudo systemctl enable docker
sudo systemctl start docker

echo "=== Vérification de l'installation ==="
docker --version
docker-compose --version

echo "=== Installation terminée ==="
echo "Veuillez vous déconnecter et vous reconnecter pour appliquer les changements de groupe."
