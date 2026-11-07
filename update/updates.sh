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
notify-send "Une mise a jour est en cours
N'éteignez pas votre PC
Et n'ouvrez ni modifier le dossier nixos-config"
sleep 8
notify-send "Mise à jour de flake..."
nix flake update
git add .
git commit -m  "mise à jour du dépot"
git push
notify-send "Téléchargement et installation en cours des MAJ ..."
sudo nixos-rebuild switch --flake
notify-send "Mise à jour terminé"
