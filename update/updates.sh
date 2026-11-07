detection=0
ouvert=0
while lsof +D /home/louis/nixos-config | grep -q "hx"; do
    notify-send "Impossible de lancer la mise à jour
                Veuillez enregistrer vos modification"
    ouvert=1
    sleep 60
done
  if [ "$ouvert" = "1" ]; then
    notify-send "Modifications enregistrées !
          Lancement de la mise à jour..."
    sleep 10
  fi
cd /home/louis/nixos-config
git add .
notify-send "Une mise a jour est en cours
N'éteignez pas votre PC
Et n'ouvrez ni modifier le dossier nixos-config"
sleep 4
notify-send "Détection de nouveaux fichiers..."
sleep 2
git status --porcelain | while read -r statut fichier; do
    # Nettoie les guillemets éventuels autour du nom de fichier
    fichier=$(eval echo "$fichier")
    
    # On filtre : uniquement les statuts de nouveaux fichiers "??' et qui se terminent par .nix
    if [[ "$statut" == "??" && "$fichier" == *.nix ]]; then
        if [ -f "$fichier" ]; then
            echo "Nouveau fichier .nix détecté : $fichier"
            
            # Lance ton action ici en parallèle si tu veux :
            # nix-build "$fichier" &
        fi
    fi
done
# 'wait' bloque le script ici jusqu'à ce que TOUS les processus en arrière-plan aient fini
wait
echo « Tous les traitements simultanés sont terminés ! »
if [ "$detection" = "0" ]; then
  notify-send "Aucun nouveaux fichiers détecté."
  sleep 4
fi
notify-send "Mise à jour de flake..."
