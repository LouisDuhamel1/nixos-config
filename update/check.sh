coupure=0
while ! ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1; do
  notify-send "Impossible de lancer la vérification.
  Veuillez vérifier votre connexion internet"
  coupure=1
  sleep 60
done

if [ "$coupure" = "1" ]; then 
  notify-send "Connexion rétabli !
  Reprise de la vérification"
fi

local_rev=$(nix eval --raw --impure --expr "(builtins.getFlake \"path:$PWD\").inputs.nixpkgs.rev" 2>/dev/null | xargs)
remote_rev=$(git ls-remote https://github.com/NixOS/nixpkgs.git nixos-unstable | cut -f1)

if [ "$local_rev" = "$remote_rev" ]; then
   echo "./updates.sh"
fi
