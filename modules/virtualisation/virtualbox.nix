{ config, pkgs, ... }:

let
  primaryUser = "louis";
in
{
  nixpkgs.config.allowUnfree = true;

  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  users.users.${primaryUser} = {
    extraGroups = [ "vboxusers" ];
  };

  environment.systemPackages = with pkgs; [
    virtualbox
  ];
}
