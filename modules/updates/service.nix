{ config, pkgs, ... }:

{
  systemd.services.mon-service = {
    description = "Mon service toutes les 6h";
    serviceConfig = {
      ExecStart = "/home/louis/nixos-config/update/check.sh";
      User = "louis";
    };
  };
}
