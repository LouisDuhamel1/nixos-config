{ pkgs, inputs, ... }:

{
  home.packages = (with pkgs; [
    alacritty
    btop
    xed-editor
    netflix
    ytmdesktop
    klavaro
    scrcpy
    vinegar
    nemo-with-extensions
    gimp
    android-tools
    ntfs3g
  ]) ++ [
    inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
  };
}
