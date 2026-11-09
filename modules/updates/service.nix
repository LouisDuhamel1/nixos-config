{ config, pkgs, ... }:

{
  systemd.services.updates = {
    description = "Mon service utilisateur toutes les 6h";
    wantedBy = [ "multi-user.target" ];
    
    path = [ pkgs.libnotify pkgs.bash pkgs.iputils pkgs.git pkgs.nix ];

    serviceConfig = {
      # Exécute directement le service en tant que ton utilisateur
      User = "louis";
      WorkingDirectory = "/home/louis/nixos-config";
      ExecStart = "/home/louis/nixos-config/update/check.sh";
      Restart = "on-failure";
      
      # Indique à systemd où trouver le bus D-Bus pour cet utilisateur
      Environment = [
        "XDG_RUNTIME_DIR=/run/user/1000"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
      ];
    };
  };
}
