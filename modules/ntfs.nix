{ config, pkgs, ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];
  services.udisks2.enable = true;
  environment.systemPackages = [ pkgs.ntfs3g ];
  fileSystems."/run/media/louis" = {
  device = "/dev/disk/by-uuid/15E51A151AE06D6C";
  fsType = "ntfs-3g";
  options = [ "noauto" "x-systemd.automount" "x-systemd.idle-timeout=600" ];
};
}
