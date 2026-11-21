{ config, pkgs, ... }:

{
  security.sudo.extraRules = [{
    users = [ "louis" ];
    commands = [{
      command = "/home/louis/nixos-config/update/updates.sh";
      options = [ "NOPASSWD" ];
    }];
  }];

  systemd.services.updates = {
    description = "Mon service utilisateur toutes les 6h";

    path = with pkgs; [
      libnotify
      bash
      iputils
      git
      nix
      coreutils
      findutils
      gnugrep
      openssh
      util-linux
      lsof
      nixos-rebuild
    ];

    serviceConfig = {
      # Exécute directement le service en tant que ton utilisateur
      Type = "oneshot";
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
