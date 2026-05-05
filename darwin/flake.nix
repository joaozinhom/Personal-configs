{
  description = "Joaozinho macOS flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowInsecurePredicate = pkg: true;
      system.primaryUser = "joaorosa";

      environment.systemPackages = with pkgs; [
        helix
        git
        cargo
        rustc
        libgccjit
        openssl
        libxml2
        libxslt
        alacritty
        wget
        curl
        unzip
        tree
        fastfetch
        obsidian
        dig
        docker
        minikube
        bitcoin
        gnupg
        pinentry_mac
        lazygit
        htop
        uv
        openssh
        libfido2
        yubikey-manager
      ];

      environment.variables = {
        GIT_SSH = "/run/current-system/sw/bin/ssh";
        GPG_TTY = "$(tty)";
        EDITOR = "hx";
      };

      homebrew = {
        enable = true;
        brews = [
          "mas"
          "trezor-agent"
          "hidapi"
          "libusb"
          "libcbor"
          "libsodium"
          # image processing stack
          "imagemagick"
          "zbar"
          # dev tools
          "cmocka"
          "cryptography"
          "hwloc"
          "libpcap"
          "pipx"
          "pyenv"
          "python@3.14"
        ];
        casks = [
          "yubico-authenticator"
          "zen"
          "zed"
          "visual-studio-code"
          "sparrow"
          "protonvpn"
          "vlc"
          "localsend"
          "utm"
          "stats"
          "vial"
          "font-opendyslexic-nerd-font"
        ];
        masApps = {};
        onActivation.cleanup = "zap";
      };

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.open-dyslexic
      ];

      system.defaults = {
        dock.autohide = true;
        dock.magnification = true;
        dock.largesize = 64;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
      };

      nix.enable = false;
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 4;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."joaorosa" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "joaorosa";
            autoMigrate = true;
          };
        }
      ];
    };
    darwinPackages = self.darwinConfigurations."joaorosa".pkgs;
  };
}
