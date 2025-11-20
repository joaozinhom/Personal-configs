{ config, pkgs, lib, ... }:
{
  # User configuration
  users.users.joaozinho.extraGroups = [ "dialout" "docker" ];

  # Environment variables
  environment.variables = {
    GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
  };
  # Services
  services = {
    tailscale.enable = true;
    libinput.enable = true;
    touchegg.enable = true;
    flatpak.enable = true;
    udev.packages = [ pkgs.vial pkgs.via ];
  };
  # Programs
  programs = {
    gnupg.agent.enable = true;
    steam.enable = true;
  };
  # Networking
  networking.firewall.checkReversePath = false;
  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;
  # Flatpak packages
  # Install these manually with:
  # flatpak install flathub com.bambulab.BambuStudio
  # flatpak install flathub com.discordapp.Discord
  # flatpak install flathub com.spotify.Client
  # flatpak install flathub org.kde.okular

  # System packages organized by category
  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    vscode
    zed-editor
    cargo
    rustc
    libgccjit
    gccgo14
    pkg-config
    openssl
    libxml2
    libxslt
    alacritty
    wget
    curl
    unzip
    neofetch
    dig
    docker
    minikube
    vial
    libgtop
    gparted
    appimage-run
    wavm
    chromium
    vivaldi
    obsidian
    localsend
    sparrow
    bitcoin
    protonvpn-gui
    gnupg
    vlc
    #obs-studio
    steam
    steam-run
    ryujinx
    #lmstudio
    flatpak
    gnome-software
    adwaita-qt
    qgnomeplatform
  ];
}
