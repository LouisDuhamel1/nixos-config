{config, pkgs, lib,...}:

{
  services.gpm.enable=true;

  systemd.services.gpm = {
    unitConfig.RefuseManualStart=false;
    serviceConfig.TimeoutStopSec=2;
  };
  systemd.sockets.gpm.enable=true;
}
