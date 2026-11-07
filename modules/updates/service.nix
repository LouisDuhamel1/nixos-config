{ config, pkgs, ... }:

{
  # On utilise systemd.user.services au lieu de systemd.services
  systemd.user.services.mon-service = {
    description = "Mon service utilisateur toutes les 6h";
    wantedBy = [ "graphical-session.target" ]; # Se lance quand ta session graphique démarre

    serviceConfig = {
      ExecStart = "/home/louis/nixos-config/update/check.sh";
      Restart = "on-failure";
    };
  };
}
