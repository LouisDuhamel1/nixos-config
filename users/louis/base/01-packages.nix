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
    libnotify
    android-tools
    ntfs3g
    inotify-tools
    lsof
    fuse3
    sqlite
    zen-beta
  ]) ++ [
    inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
  };
}
