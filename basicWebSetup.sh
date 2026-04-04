#!/bin/bash

# ------------------------------
# Script LAMP avec VirtualHost perso
# ------------------------------

echo "Mise à jour du système..."
sudo apt update && sudo apt upgrade -y

echo "Installation Apache..."
sudo apt install -y apache2

echo "Installation MySQL..."
sudo apt install -y mysql-server

echo "Installation PHP..."
sudo apt install -y php libapache2-mod-php php-mysql

echo "Activation Apache..."
sudo systemctl start apache2
sudo systemctl enable apache2

echo "Configuration sécurisée MySQL..."
echo "Réponds aux questions (recommandé : Y partout sauf cas spécifique)"
sudo mysql_secure_installation

# ------------------------------
# Finalisation
# ------------------------------
echo ""
echo "Setup terminé !"
echo "Ton site est accessible ici : http://prog-web.local"
echo "Tu peux maintenant créer tes fichiers PHP directement dans /var/www/html"
echo "index.php avec phpinfo() a été créé automatiquement."