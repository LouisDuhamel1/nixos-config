REPERTOIRE="/home/louis/nixos-config"



fichier=$(inotifywait -t 10 -e modify,open,close_write --format '%f' "$REPERTOIRE")
while read -r fichier; do
    echo "Activité détectée (en cours de modification/écriture) sur : $fichier"
done

