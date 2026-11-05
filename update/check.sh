local_rev=$(grep -m 1 '"rev":' ~/nixos-config/flake.lock | cut -d'"' -f4)
remote_rev=$(git ls-remote https://github.com/NixOS/nixpkgs.git nixos-unstable | cut -f1)
if [ "$local_rev" = "$remote_rev" ]; then
   echo "./updates.sh"
else
  echo "test"
fi

