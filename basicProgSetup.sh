#!/bin/bash

echo "Mise à jour du système..."
sudo apt update && sudo apt upgrade -y

echo "Installation des outils de base..."
sudo apt install -y \
    git \
    curl \
    wget \
    unzip \
    build-essential \
    software-properties-common

echo "Configuration de Git..."
read -p "Entre ton nom Git : " git_name
read -p "Entre ton email Git : " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

echo "Génération clé SSH pour GitHub..."
ssh-keygen -t ed25519 -C "$git_email" -f ~/.ssh/id_ed25519 -N ""

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Voici ta clé publique (à ajouter sur GitHub) :"
cat ~/.ssh/id_ed25519.pub

echo ""
echo "Ajoute cette clé ici : https://github.com/settings/keys"
echo "Puis appuie sur ENTER pour continuer..."
read

echo "Test connexion GitHub..."

# Capture de la sortie + code retour
ssh_output=$(ssh -T git@github.com 2>&1)
ssh_status=$?

echo "$ssh_output"

# Vérification des cas
if echo "$ssh_output" | grep -q "Permission denied (publickey)"; then
    echo ""
    echo "ERREUR : Clé SSH non reconnue par GitHub !"
    echo "Vérifie que tu as bien ajouté ta clé sur : https://github.com/settings/keys"
    echo "Relance ensuite le script ou refais le test avec : ssh -T git@github.com"
elif echo "$ssh_output" | grep -q "successfully authenticated"; then
    echo ""
    echo "Connexion à GitHub réussie !"
else
    echo ""
    echo "Réponse inattendue de GitHub. Vérifie manuellement la connexion."
fi

echo ""
echo "Setup terminé ! Tu as désormais une configuration de base Ubuntu WSL et git."