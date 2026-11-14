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

    multiverse.url = "github:fzakaria/nixpkgs-multiverse";
  };


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
        modules = [ 
          ./hosts/ideapad3/configuration.nix 
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ prev.pkg-config ];
                buildInputs = (oldAttrs.buildInputs or []) ++ [ prev.sqlite prev.fuse3 ];
        
                 # Variables indispensables pour que le paquet Rust trouve SQLite et FUSE
                SQLITE3_LIB_DIR = "${prev.sqlite.out}/lib";
                SQLITE3_INCLUDE_DIR = "${prev.sqlite.dev}/include";
                PKG_CONFIG_PATH = "${prev.sqlite.dev}/lib/pkgconfig:${prev.fuse3.dev}/lib/pkgconfig";
        
                NIX_LDFLAGS = (oldAttrs.NIX_LDFLAGS or "") + " -L${prev.sqlite.out}/lib -L${prev.fuse3.out}/lib";
              });
      
                  nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ prev.pkg-config ];
                  buildInputs = (oldAttrs.buildInputs or []) ++ [ prev.sqlite prev.fuse3 ];
        
                  SQLITE3_LIB_DIR = "${prev.sqlite.out}/lib";
                  SQLITE3_INCLUDE_DIR = "${prev.sqlite.dev}/include";
                  PKG_CONFIG_PATH = "${prev.sqlite.dev}/lib/pkgconfig:${prev.fuse3.dev}/lib/pkgconfig";
        
                  NIX_LDFLAGS = (oldAttrs.NIX_LDFLAGS or "") + " -L${prev.sqlite.out}/lib -L${prev.fuse3.out}/lib";
                });
              })
            ];
          })         
        ];
      };
    };
}
