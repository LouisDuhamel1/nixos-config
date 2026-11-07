{ config, pkgs, ... }:

{
 systemd.timers.mon-service = {
    description = "Timer toutes les 6 heures";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # S'exécute à 00:00, 06:00, 12:00 et 18:00
      OnCalendar = "*:6/0";
      Persistent = true;
    };
  };
}
