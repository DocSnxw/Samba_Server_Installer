# 🔒 Script d'Installation Automatisée Samba

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnu-bash&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Debian%20%7C%20Ubuntu-E95420?logo=ubuntu&logoColor=white)

> 📦 Solution clé en main pour déployer un serveur Samba sécurisé sur Debian/Ubuntu

## ⚡ Caractéristiques principales

- 🔐 Configuration sécurisée (SMB2/3 uniquement)
- 👥 Gestion automatisée des utilisateurs
- 🛡️ Configuration du pare-feu intégrée
- 💾 Sauvegarde automatique des configurations
- 🚀 Installation rapide en une commande

## 📋 Prérequis

| Élément | Détail |
|---------|---------|
| 💻 OS | Debian/Ubuntu |
| 🔑 Droits | Root (sudo) |
| 🌐 Réseau | Connexion Internet active |

## 🚀 Installation

1️⃣ **Cloner le repository**
```bash
git clone [URL_DU_REPO]
```

2️⃣ **Rendre le script exécutable**
```bash
chmod +x smb_installer.sh
```

3️⃣ **Lancer l'installation**
```bash
sudo ./smb_installer.sh
```

## ⚙️ Configuration

Le script vous guidera pour configurer :

| Paramètre | Description |
|-----------|-------------|
| 👤 Utilisateur UNIX | Nom du compte système |
| 🔑 Mot de passe UNIX | Mot de passe du compte système |
| 🔒 Mot de passe Samba | Mot de passe pour l'accès au partage |
| 📁 Nom du partage | Nom du répertoire partagé |

## 🛡️ Sécurité

- ✅ Protocoles SMB1 désactivés
- ✅ Accès invité désactivé
- ✅ Pare-feu UFW configuré
- ✅ Permissions restrictives

## 📝 Licence

Ce projet est sous licence MIT. Voir le fichier [`LICENSE`](LICENSE) pour plus de détails.

## 💬 Support

Pour toute question ou problème :

- 🐛 Ouvrez une [issue](https://github.com/votre-repo/issues)

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
1. 🍴 Forker le projet
2. 🔧 Créer votre branche (`git checkout -b feature/AmazingFeature`)
3. 💾 Committer vos changements (`git commit -m 'Add AmazingFeature'`)
4. 📤 Pusher sur la branche (`git push origin feature/AmazingFeature`)
5. 📫 Ouvrir une Pull Request

---

<div align="center">
  
**Made with ❤️ by DocSnxw**

</div>