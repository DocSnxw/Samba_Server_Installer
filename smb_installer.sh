#!/bin/bash

# Fonction pour gérer les erreurs
handle_error() {
    echo "Erreur: $1"
    exit 1
}

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]; then 
    handle_error "Ce script doit être exécuté en tant que root"
fi

# Vérifier si Samba est déjà installé
if dpkg -l | grep -q "^ii.*samba "; then
    read -p "Samba est déjà installé. Voulez-vous continuer? (o/n) " choice
    if [ "$choice" != "o" ]; then
        exit 0
    fi
fi

# Demander les informations à l'utilisateur
while true; do
    read -p "Entrez le nom d'utilisateur UNIX: " unix_user
    if [[ "$unix_user" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
        break
    else
        echo "Nom d'utilisateur invalide. Utilisez uniquement des lettres minuscules, chiffres, - et _"
    fi
done

while true; do
    read -p "Entrez le mot de passe pour l'utilisateur UNIX: " -s unix_password
    echo
    read -p "Confirmez le mot de passe: " -s unix_password_confirm
    echo
    if [ "$unix_password" = "$unix_password_confirm" ]; then
        break
    else
        echo "Les mots de passe ne correspondent pas."
    fi
done

# Configuration similaire pour SMB
smb_user=$unix_user
read -p "Entrez le mot de passe pour l'utilisateur SMB: " -s smb_password
echo

read -p "Entrez le nom du partage Samba: " smb_share

# Sauvegarde du fichier de configuration
cp /etc/samba/smb.conf /etc/samba/smb.conf.backup || handle_error "Impossible de sauvegarder smb.conf"

# Installation et mise à jour
echo "Mise à jour du système..."
apt update || handle_error "Échec de la mise à jour"
apt install -y samba ufw || handle_error "Échec de l'installation de Samba"

# Création de l'utilisateur
useradd -m "$unix_user" || handle_error "Impossible de créer l'utilisateur"
echo "$unix_user:$unix_password" | chpasswd

# Configuration SMB
(echo "$smb_password"; echo "$smb_password") | smbpasswd -a "$smb_user" || handle_error "Échec de la création de l'utilisateur SMB"

# Configuration Samba sécurisée
cat > /etc/samba/smb.conf <<EOL
[global]
   workgroup = WORKGROUP
   server string = Samba Server
   server role = standalone server
   log file = /var/log/samba/log.%m
   max log size = 50
   dns proxy = no
   security = user
   encrypt passwords = true
   passdb backend = tdbsam
   unix password sync = yes
   map to guest = never
   client min protocol = SMB2
   client max protocol = SMB3

[$smb_share]
   path = /home/$unix_user
   valid users = $smb_user
   read only = no
   browsable = yes
   create mask = 0660
   directory mask = 0750
   force user = $unix_user
   force group = $unix_user
EOL

# Configuration du pare-feu
ufw allow Samba
ufw enable

# Redémarrage des services
systemctl restart smbd || handle_error "Impossible de redémarrer Samba"
systemctl enable smbd || handle_error "Impossible d'activer le démarrage automatique de Samba"

echo "Installation terminée avec succès!"
echo "Partage accessible via: \\\\$(hostname)\\$smb_share"
echo "Utilisez les identifiants suivants:"
echo "Utilisateur: $smb_user"
