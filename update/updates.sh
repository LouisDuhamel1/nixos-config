#!/usr/bin/env bash
set -e

notify_louis() {
  runuser -u louis -- env \
    XDG_RUNTIME_DIR=/run/user/1000 \
    DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
    notify-send "$@"
}

detection=0
ouvert=0

while lsof +D /home/louis/nixos-config 2>/dev/null | grep -q "hx"; do
  notify_louis "Impossible de lancer la mise à jour" "Veuillez enregistrer vos modifications"
  ouvert=1
  sleep 60
done

if [ "$ouvert" = "1" ]; then
  notify_louis "Modifications enregistrées !" "Lancement de la mise à jour..."
  sleep 10
fi

cd /home/louis/nixos-config

notify_louis "Une mise à jour est en cours" "N'éteignez pas votre PC et ne modifiez pas le dossier nixos-config"
sleep 8

notify_louis "Mise à jour du flake..."
runuser -u louis -- nix flake update
runuser -u louis -- git add .
if ! runuser -u louis -- git diff --cached --quiet; then
  runuser -u louis -- git commit -m "mise à jour du dépôt"
  runuser -u louis -- git push
fi

notify_louis "Téléchargement et installation des MAJ..."
nixos-rebuild switch --flake /home/louis/nixos-config

notify_louis "Mise à jour terminée !"
