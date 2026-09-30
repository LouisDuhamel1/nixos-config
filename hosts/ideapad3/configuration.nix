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

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];

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
  };

  my.profile = "laptop";
  my.bluetooth.powerOnBoot = true;
  my.compatibility.nix-ld.enable = true;
  my.desktop.hyprland.enable = true;
  my.graphics.amd.enable = true;
  my.location.geoclue2.enable = true;
  my.virtualisation.libvirt.enable = true;
  my.virtualisation.libvirt.user = myConfig.username;
}
