{ pkgs, ... }:

{
  programs = {
    bat.enable = true;
    htop.enable = true;
    kdeconnect.enable = true;
  };

  environment.systemPackages = with pkgs; [
    file
    pciutils
    sops
    ssh-to-age
    usbutils
  ];
}
