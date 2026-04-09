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
      ];

      environment.variables = {
        TREZOR_PASSPHRASE = "";
        GIT_SSH = "/run/current-system/sw/bin/ssh";
        GPG_TTY = "$(tty)";
        EDITOR = "hx";
      };

      system.activationScripts.sshConfig = {
        text = ''
          mkdir -p /Users/joaorosa/.ssh
          cat > /Users/joaorosa/.ssh/config << 'EOF'
Host github.com
  User git
  IdentityFile ~/.ssh/id_ecdsa_sk
EOF
          chown joaorosa /Users/joaorosa/.ssh/config
          chmod 600 /Users/joaorosa/.ssh/config
        '';
      };

      system.activationScripts.gpgConfig = {
        text = ''
          mkdir -p /Users/joaorosa/.gnupg
          cat > /Users/joaorosa/.gnupg/gpg-agent.conf << 'EOF'
default-cache-ttl 28800
max-cache-ttl 86400
pinentry-program /run/current-system/sw/bin/pinentry-mac
enable-ssh-support
EOF
          chmod 700 /Users/joaorosa/.gnupg
          chmod 600 /Users/joaorosa/.gnupg/gpg-agent.conf
          chown -R joaorosa /Users/joaorosa/.gnupg
        '';
      };

      launchd.user.agents.gpg-agent = {
        serviceConfig = {
          ProgramArguments = [
            "/run/current-system/sw/bin/gpgconf"
            "--launch"
            "gpg-agent"
          ];
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "/tmp/gpg-agent.log";
          StandardErrorPath = "/tmp/gpg-agent.log";
        };
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
        dock.persistent-apps = [
          "${pkgs.alacritty}/Applications/Alacritty.app"
          "/Applications/Zen Browser.app"
          "/Applications/VLC.app"
          "/Applications/Visual Studio Code.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
        ];
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
