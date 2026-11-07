{ config, pkgs, ... }:

{
  systemd.services.mon-service = {
    description = "Mon service toutes les 6h";
    wantedBy = [ "multi-user.target" ];
    
    # Injecte directement libnotify et bash dans le PATH du service
    path = [ pkgs.libnotify pkgs.bash ];

    serviceConfig = {
      ExecStart = "/home/louis/nixos-config/update/check.sh";
      User = "louis";
      Restart = "on-failure";
      
      # Fournit l'accès au serveur graphique et au bus de session utilisateur
      Environment = [
        "DISPLAY=:0"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
        "XDG_RUNTIME_DIR=/run/user/1000"
      ];
    };
  };
}
