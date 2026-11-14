{ config, lib, myConfig, pkgs, ... }:

let
  homeDirectory = config.users.users.${myConfig.username}.home;
  caches = import ./caches.nix { inherit myConfig; };
in

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      # Déduplique les fichiers identiques à chaque ajout au magasin.
      auto-optimise-store = true;

      # Lance une collecte en cours de construction si l'espace devient faible.
      # Nix s'arrête dès que max-free est atteint ou qu'il n'y a plus de déchets.
      min-free = 5 * 1024 * 1024 * 1024;
      max-free = 10 * 1024 * 1024 * 1024;

      substituters =
        caches.personalSubstituters
        ++ [ "https://cache.nixos.org" ]
        ++ caches.publicSubstituters;

      trusted-public-keys =
        [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ]
        ++ caches.personalTrustedPublicKeys
        ++ caches.publicTrustedPublicKeys;

    };

    gc = {
      automatic = true;
      dates = "weekly";
      # Supprime les générations de plus de sept jours.
      options = "--delete-older-than 7d";
    };
  };

}
