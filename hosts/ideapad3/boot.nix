{ pkgs, ... }:

{
  boot = {
    loader = {
      limine = {
        enable = true;
        maxGenerations = 20;
        style = {
          wallpapers = [
            (pkgs.fetchurl {
              name = "nix-wallpaper.png";
              url = "https://wallpaperaccess.com/full/23970580.jpg";
              hash = "sha256-5DcL/eP6BYg8NIhVDxrgRiyt4EYd5dg6bBShzpYqUWE=";
            })
          ];
          wallpaperStyle = "stretched";
        };
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };

    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore;
    kernelParams = [
      "loglevel=3"
      "rd.systemd.show_status=false"
    ];
    consoleLogLevel = 3;

    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    initrd = {
      kernelModules = [ "xe" ];
      systemd.enable = true;
      verbose = false;
    };
  };
}
