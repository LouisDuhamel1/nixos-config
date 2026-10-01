{ config, pkgs, lib, ... }:

let
  cfg = config.my.power;

  setChargeThreshold = pkgs.writeShellScript "set-battery-charge-threshold" ''
    set -eu

    # Generic Linux charge threshold
    for battery in /sys/class/power_supply/*; do
      [ -f "$battery/type" ] || continue
      [ "$(cat "$battery/type")" = "Battery" ] || continue

      threshold="$battery/charge_control_end_threshold"

      if [ -e "$threshold" ]; then
        echo ${toString cfg.batteryChargeLimit} > "$threshold"
        exit 0
      fi
    done

    # Lenovo IdeaPad conservation mode
    conservation="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

    if [ -e "$conservation" ]; then
      echo 1 > "$conservation"
      exit 0
    fi

    echo "Aucune interface de seuil de charge compatible n'a été trouvée." >&2
    exit 1
  '';
in
{
  options.my.power.batteryChargeLimit = lib.mkOption {
    type = lib.types.nullOr (lib.types.ints.between 1 100);
    default = null;
    description = "Limite de charge de la batterie en pourcentage.";
  };

  config = lib.mkIf (cfg.batteryChargeLimit != null) {
    systemd.services.battery-charge-threshold = {
      description = "Limiter la charge de la batterie";
      wantedBy = [ "multi-user.target" ];
      after = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = setChargeThreshold;
        RemainAfterExit = true;
      };
    };
  };
}
