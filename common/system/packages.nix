{ pkgs, inputs, ... }:

let
  satur8 = import ./satur8.nix {
    inherit pkgs inputs;
  };
in
{
  environment.systemPackages = with pkgs; [
    cachix
    fastfetch
    file
    pciutils
    ripgrep
    tree
    usbutils
    peazip
    celluloid
    udiskie
    libreoffice
    satur8
    inputs.omnibin.packages.${pkgs.stdenv.hostPlatform.system}.omnibin-shell
    inputs.multiverse.packages.${pkgs.stdenv.hostPlatform.system}.mvs
  ];
}
