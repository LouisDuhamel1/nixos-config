{ config, pkgs, ... }:

{
  systemd.services.mon-service = {
    description = "Mon service toutes les 6h";
    wantedBy = [ "multi-user.target" ];
    
    # Ajoute les paquets indispensables directement dans le PATH du service
    path = [ pkgs.libnotify pkgs.bash ];

    serviceConfig = {
      ExecStart = "/home/louis/nixos-config/update/check.sh";
      User = "louis";
      Restart = "on-failure";
      
      # On garde uniquement l'accès à la session graphique ici
      Environment = [
        "DISPLAY=:0"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
      ];
    };
  };
}
