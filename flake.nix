{
  description = "NixOS + Home Manager Flake pour Ideapad3";

  nixConfig = {
    # Nix exige des valeurs littérales dans nixConfig : impossible d'importer
    # caches.nix ou config.nix ici. Garder cette liste synchronisée avec
    # common/system/caches.nix.
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://freesmlauncher.cachix.org"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "freesmlauncher.cachix.org-1:Jcp5Q9wiLL+EDv8Mh7c6L9xGk+lXr7/otpKxMOuBuDs="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  

  inputs = {
    freesmlauncher.url = "github:FreesmTeam/FreesmLauncher/develop";
      home-manager = {  
      url = "github:nix-community/home-manager/master";
      };   
    zen-browser = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

   # nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.backupFileExtension
    multiverse.url = "github:fzakaria/nixpkgs-multiverse";
  };

outputs = { self, nixpkgs, zen-browser,  ... }@inputs:
   let
      myConfig = import ./config.nix;
      repoSource = nixpkgs.lib.fileset.toSource {
        root = ./.;
        # Cette liste doit rester alignée avec les paths-ignore de
        # .github/workflows/build-installer-iso.yml.
        fileset = nixpkgs.lib.fileset.difference ./.
          (nixpkgs.lib.fileset.unions [ ./.github ./README.md ./.gitignore ]);
      };
    in
    {
      nixosConfigurations.installer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          modulesPath = "${nixpkgs}/nixos/modules";
          inherit repoSource;
        };
        modules = [ ./installer/iso.nix ];
      };

      nixosConfigurations.Ideapad3 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs myConfig; };
        modules = [ ./hosts/ideapad3/configuration.nix ];
      };
    };
}
