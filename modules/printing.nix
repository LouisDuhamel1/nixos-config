{ config, pkgs, ... }:

{
  # Activer CUPS
  services.printing.enable = true;

  # Activer la détection réseau (Avahi)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Ajouter les pilotes nécessaires (notamment hplip pour votre HP DeskJet)
  services.printing.drivers = with pkgs; [
    hplip
    gutenprint
  ];
}
