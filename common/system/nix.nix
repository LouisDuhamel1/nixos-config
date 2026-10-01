{ config, lib, myConfig, pkgs, ... }:

let
  homeDirectory = config.users.users.${myConfig.username}.home;
in

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      substituters =
        [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://attic.xuyh0120.win/lantian"
          "https://freesmlauncher.cachix.org"
          "https://noctalia.cachix.org"
        ]
        ++ lib.optional myConfig.cachix.enable "https://${myConfig.cachix.name}.cachix.org";

      trusted-public-keys =
        [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "freesmlauncher.cachix.org-1:Jcp5Q9wiLL+EDv8Mh7c6L9xGk+lXr7/otpKxMOuBuDs="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ]
        ++ lib.optional myConfig.cachix.enable
          "${myConfig.cachix.name}.cachix.org-1:${myConfig.cachix.publicKey}";

    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    optimise.automatic = true;
  };

}
