# 🔍 Bash "version"

Un utilitaire Bash simple mais pratique qui détecte automatiquement la méthode appropriée pour afficher la version d'un programme.

## 🚫 Problème résolu

Chaque programme utilise une option différente pour afficher sa version :
- `--version`
- `-v`
- `-V`
- `version`
- etc.

Ce script teste automatiquement les différentes options pour trouver celle qui fonctionne avec le programme spécifié.

## 📥 Installation

```bash
# Cloner le dépôt
git clone https://github.com/popallo/bash-version.git
cd bash-version

# Rendre le script exécutable
chmod +x version.sh

# Optionnel : Installer globalement
sudo cp version.sh /usr/local/bin/version
```

## 🚀 Utilisation

### 📝 Syntaxe de base

```bash
./version.sh programme
```

Exemple :
```bash
./version.sh python
```

Sortie :
```
Python 3.10.12 (main, Jun 11 2023, 05:26:28) [GCC 11.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
```

### 🔢 Afficher uniquement le numéro de version

Utilisez l'option `-s` ou `--short` :

```bash
./version.sh -s python
```

Sortie :
```
3.10.12
```

## ⚙️ Comment ça marche

Le script essaie séquentiellement les options suivantes sur le programme spécifié :
1. `--version`
2. `-V`
3. `-v`
4. `--ver`
5. `version`
6. `ver`
7. `-version`
8. Exécution sans arguments (dernier recours)

Dès qu'une commande renvoie un résultat contenant un format de version (comme x.y.z), le script affiche cette sortie.

## 🛠️ Options

| Option | Description |
|--------|-------------|
| `-s`, `--short` | Affiche uniquement le numéro de version (ex: 1.2.3) sans texte supplémentaire |

## 📋 Exemples d'utilisation

```bash
# Afficher la version de Git
./version.sh git

# Afficher uniquement le numéro de version de Node.js
./version.sh -s node

# Si installé globalement
version python
version -s npm
```

## 🔄 Compatibilité

Ce script a été testé sur :
- Bash 4.0+
- La plupart des distributions Linux
- macOS

## 📜 Licence

Ce projet est sous licence MIT - voir le fichier LICENSE pour plus de détails.

## 👥 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à soumettre une Issue ou une Pull Request.
