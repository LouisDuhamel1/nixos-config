{ pkgs, inputs, ... }:

pkgs.rustPlatform.buildRustPackage {
  pname = "satur8";
  version = "unstable";

  src = inputs.satu8;

  cargoLock = {
    lockFile = "${inputs.satu8}/Cargo.lock";
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    openssl
    fontconfig
  ];

  buildPhase = ''
  cargo build --release -p satur8-cli -p satur8-daemon -p satur8-gui
'';

installPhase = ''
  mkdir -p $out/bin

  install -Dm755 target/release/satur8 $out/bin/satur8
  install -Dm755 target/release/satur8-daemon $out/bin/satur8-daemon
  install -Dm755 target/release/satur8-gui $out/bin/satur8-gui
'';


  meta = {
    description = "Per-game digital vibrance for Linux";
    homepage = "https://github.com/NtrpyDev/satur8";
    license = pkgs.lib.licenses.gpl3Only;
    platforms = pkgs.lib.platforms.linux;
  };
}
