{ inputs, myConfig, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ../../common
    ../../users/louis/storage.nix
  ];
  networking.hostName = "Ideapad3";
  system.stateVersion = "26.05";
 # nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  nixpkgs.overlays = [
  (final: prev: {
    nixos-manual-html = prev.nixos-manual-html.overrideAttrs (old: {
      preBuild = (old.preBuild or "") + ''
        substituteInPlace redirects.json \
          --replace-fail '{' '{
            "module-pelican-wings": "index.html",
            "module-pelican-wings-setup": "index.html",
            "module-pelican-panel-reverse-proxy": "index.html",
            "module-pelican-panel-basic-usage": "index.html",
            "module-pelican-panel-environment": "index.html",
            "module-pelican-wings-traefik": "index.html",'
          '';
        });
      })
    ];

  nix.settings.extra-experimental-features = [ "no-lazy-trees" ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs myConfig; };
    users.${myConfig.username} = {
      imports = [
        ../../users/louis/base
        ../../users/louis/variants/ideapad3.nix
      ];
    
    };
    backupFileExtension = "backup";
  };
 nix.settings.trusted-users = [ "root" "louis" ];
  
  my.profile = "laptop";
  my.bluetooth.powerOnBoot = false;
  my.compatibility.nix-ld.enable = true;
  my.desktop.hyprland.enable = true;
  my.graphics.amd.enable = true;
  my.location.geoclue2.enable = true;
  my.virtualisation.libvirt.enable = true;
  my.virtualisation.libvirt.user = myConfig.username;
 }
