{config, pkgs, lib,...}:

{
  services.gpm.enable=true;
  systemd.services.gpm.unitConfig.RefuseManualStart=false;
  systemd.sockets.gpm.enable=true;
}
