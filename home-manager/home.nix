{ config, pkgs, inputs, ... }:

# Linux (Omarchy/Hyprland) home-manager config mirroring ../darwin/flake.nix.
#
# macOS-only tools NOT ported here, and how they're handled instead:
#   - Docker Desktop / Colima / Lima / OrbStack
#       -> Linux runs containers natively. Install the engine at the system
#          level (`omarchy install docker`), not through home-manager, since
#          it needs a root daemon + systemd unit. minikube: same story,
#          install system-wide once docker/podman is up.
#   - UTM
#       -> nearest equivalent is virt-manager + qemu (GNOME Boxes also
#          works). Not added here yet; system-level install if/when needed.
#   - Stats (menu bar system monitor)
#       -> covered by the Omarchy bar + btop/htop.
#   - XQuartz
#       -> not needed, Hyprland is native Wayland/X11.
#   - mas (Mac App Store CLI)
#       -> no equivalent needed on Linux.
#   - pinentry_mac
#       -> swapped for pinentry-curses below (works in-terminal under hx/tmux).
#
# Everything else from darwin/flake.nix's systemPackages + homebrew
# brews/casks is ported 1:1 or to its closest Linux/nixpkgs equivalent below.

{
  home.username = "joaozinhom";
  home.homeDirectory = "/home/joaozinhom";

  # See darwin/flake.nix's `system.stateVersion` for the mac side; this one
  # tracks home-manager's own release. Set to 26.05 to match the generation
  # already activated on this machine — do not lower it on later upgrades.
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    # --- darwin systemPackages parity ---
    helix
    alacritty
    git
    cargo
    rustc
    libgccjit
    openssl
    libxml2
    libxslt
    wget
    curl
    unzip
    tree
    fastfetch
    obsidian
    dig
    docker # CLI only here; the daemon/service is installed at the system level
    bitcoin
    gnupg
    pinentry-curses # was pinentry_mac on darwin
    lazygit
    htop
    uv
    openssh
    libfido2
    yubikey-manager
    claude-code
    codex

    # --- homebrew casks -> nixpkgs equivalents ---
    vscode # was: visual-studio-code
    sparrow # bitcoin wallet, same app cross-platform
    protonvpn-gui # was: protonvpn
    localsend
    vial # QMK/VIA keyboard configurator
    yubioath-flutter # was: yubico-authenticator
    tor-browser
    inputs.zen-browser.packages.${pkgs.system}.default # was commented out (# "zen") in darwin/flake.nix casks; already in use on this machine

    # --- homebrew brews -> nixpkgs equivalents ---
    trezor-agent
    hidapi
    libusb1
    libcbor
    libsodium
    imagemagick
    zbar
    cmocka
    hwloc
    libpcap
    pipx
    pyenv
    python313 # closest to darwin's python@3.14 currently packaged
    aria2
    gh

    # --- already-Linux-native extras kept from the previous home.nix ---
    tailscale
    libgtop
    pkg-config
    gccgo14

    # --- fonts (was fonts.packages on darwin) ---
    nerd-fonts.jetbrains-mono
    nerd-fonts.open-dyslexic
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
    GPG_TTY = "$(tty)";
  };

  # Dotfiles are symlinked straight to the files tracked in this repo
  # (Personal-configs/alacritty, Personal-configs/helix) so editing them
  # in place and re-running `home-manager switch` is all that's needed —
  # no copy drifts out of sync with git.
  home.file = {
    ".config/alacritty/alacritty.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Personal-configs/alacritty/alacritty.toml";

    ".config/helix/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Personal-configs/helix/config.toml";

    # NOTE: helix/tokyo-night.toml is written in Alacritty's theme format
    # ([colors.primary]/[colors.normal]/...), not Helix's theme schema
    # (ui.background/ui.cursor/...). It looks misplaced rather than an
    # intentional Helix theme override, so it's left untouched in the repo
    # and NOT symlinked into ~/.config/helix/themes/. config.toml already
    # selects Helix's built-in "tokyonight" theme, which needs no extra file.
  };

  programs.home-manager.enable = true;
}
