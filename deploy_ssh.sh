#!/bin/bash
set -e

# 1️⃣ Générer une clé SSH si elle n'existe pas
KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$KEY" ]; then
    echo "Création d'une nouvelle clé SSH..."
    ssh-keygen -t ed25519 -C "alibassa1982@gmail.com" -f "$KEY" -N ""
else
    echo "Clé SSH déjà existante."
fi

# 2️⃣ Afficher la clé publique pour GitHub
echo ""
echo "-----------------------------------------"
echo "Clé publique à copier dans GitHub SSH Keys:"
cat "$KEY.pub"
echo "-----------------------------------------"
echo ""

echo "Après avoir ajouté la clé sur GitHub, appuyez sur Entrée pour continuer..."
read

# 3️⃣ Tester la connexion SSH
ssh -T git@github.com || echo "Vérifiez que la clé est bien ajoutée à GitHub !"

# 4️⃣ Créer le dossier site si nécessaire
mkdir -p ~/site
cd ~/site

# 5️⃣ Créer index.html si inexistant
if [ ! -f index.html ]; then
    echo "<!DOCTYPE html><html><head><meta charset='utf-8'><title>Site WhatsApp</title></head><body><h1>Bienvenue sur le site WhatsApp</h1></body></html>" > index.html
fi

# 6️⃣ Initialiser Git
if [ ! -d .git ]; then
    git init
    git branch -M main
fi

# 7️⃣ Lier le dépôt SSH (remplace TonNomGitHub/site par ton dépôt)
git remote remove origin 2>/dev/null || true
git remote add origin git@github.com:TonNomGitHub/site.git

# 8️⃣ Ajouter, commit et push
git add .
git commit -m "Mise en ligne du site WhatsApp"
git push -u origin main

echo ""
echo "✅ Le site est maintenant poussé sur GitHub !"
echo "Vous pouvez accéder à GitHub Pages si activé dans les Settings du dépôt."
