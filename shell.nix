let
  rust-overlay = builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz";
  pkgs = import <nixpkgs> {
    overlays = [(import rust-overlay)];
  };
  toolchain = pkgs.rust-bin.fromRustupToolchainFile ./toolchain.toml;
  libraries = with pkgs;[
    webkitgtk
    gtk3
    cairo
    gdk-pixbuf
    glib
    dbus
    openssl_3
    librsvg
    libgpg-error 
    xorg.libX11
    xorg.libSM
    xorg.libICE
    xorg.libxcb
    fribidi
    fontconfig
    libthai
    harfbuzz
    freetype
    libglvnd
    mesa
    libdrm
  ];
  packages = with pkgs; [
    pkg-config
    curl
    wget
    dbus
    openssl_3
    glib
    gtk3
    libsoup
    webkitgtk
    appimagekit
    librsvg
    nodejs_22
    nodePackages.pnpm
    nodePackages.vscode-json-languageserver
    rust-analyzer
    rustfmt
    cargo
    rustc
    toolchain
  ];
in
pkgs.mkShell {
  env = {
    
  };
  buildInputs = libraries ++ packages;
  shellHook =
    ''
      exprot RUST_BACKTRACE=full;
      export WEBKIT_DISABLE_COMPOSITING_MODE=1
      export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH
      export XDG_DATA_DIRS=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS
      export OPENSSL_INCLUDE_DIR="${pkgs.openssl.dev}/include/openssl"
      export OPENSSL_LIB_DIR="${pkgs.openssl.out}/lib"
      export OPENSSL_ROOT_DIR="${pkgs.openssl.out}"
      export RUST_SRC_PATH="${toolchain}/lib/rustlib/src/rust/library"
    '';
}
