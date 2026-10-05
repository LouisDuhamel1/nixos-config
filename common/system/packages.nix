{ pkgs, inputs, ... }:

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
    lmms
    inputs.omnibin.packages.${pkgs.stdenv.hostPlatform.system}.omnibin-shell
    inputs.multiverse.packages.${pkgs.stdenv.hostPlatform.system}.mvs
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
 ];
}
