#!/bin/bash

# Script pour afficher la version d'un logiciel
# Usage: ./version.sh [-s|--short] programme

# Vérifier si au moins un argument a été passé
if [ $# -eq 0 ]; then
    echo "Usage: $0 [-s|--short] programme"
    exit 1
fi

# Vérifier si l'option short est présente
SHORT=false
PROGRAM=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -s|--short)
            SHORT=true
            shift
            ;;
        *)
            PROGRAM="$1"
            shift
            ;;
    esac
done

# Vérifier si le programme existe
if ! command -v "$PROGRAM" &> /dev/null; then
    echo "Erreur: $PROGRAM n'est pas trouvé dans le PATH"
    exit 1
fi

# Liste des options possibles pour afficher la version
VERSION_OPTIONS=(
    "--version"
    "-V"
    "-v"
    "--ver"
    "version"
    "ver"
    "-version"
)

# Fonction pour extraire juste le numéro de version
extract_version_number() {
    local output="$1"
    # Rechercher un pattern commun pour les numéros de version (ex: 1.2.3)
    if [[ "$SHORT" == "true" ]]; then
        echo "$output" | grep -Eo '[0-9]+\.[0-9]+(\.[0-9]+)?([a-zA-Z0-9_\-\.]+)?' | head -1
    else
        echo "$output"
    fi
}

# Tester chaque option
for option in "${VERSION_OPTIONS[@]}"; do
    output=$("$PROGRAM" $option 2>&1)
    exit_code=$?
    
    # Si la commande s'est exécutée avec succès et que la sortie contient un numéro de version
    if [ $exit_code -eq 0 ] && (echo "$output" | grep -Eq '[0-9]+\.[0-9]+'); then
        # Afficher le résultat selon l'option short
        extract_version_number "$output"
        exit 0
    fi
done

# En cas d'échec avec toutes les options, essayer d'exécuter le programme sans arguments
# car certains programmes affichent la version sans option spécifique
output=$("$PROGRAM" 2>&1)
exit_code=$?

if [ $exit_code -eq 0 ] && (echo "$output" | grep -Eq '[0-9]+\.[0-9]+'); then
    extract_version_number "$output"
    exit 0
fi

# Si aucune option ne fonctionne
echo "Impossible de déterminer la version de $PROGRAM"
exit 1
