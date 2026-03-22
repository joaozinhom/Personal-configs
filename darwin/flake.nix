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
      nixpkgs.config.allowInsecure = true;

      system.primaryUser = "joaorosa";

      environment.systemPackages = with pkgs; [
        neovim
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
        fastfetch
        obsidian
        dig
        docker
        minikube
        bitcoin
        gnupg
        lazygit
        htop
        uv
        openssh
        libfido2
      ];

      environment.variables = {
        TREZOR_PASSPHRASE = "";
        GIT_SSH = "/run/current-system/sw/bin/ssh";
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

      homebrew = {
        enable = true;
        brews = [
          "mas"
        ];
        casks = [
          "zen"
          "visual-studio-code"
          "sparrow"
          "protonvpn"
          "vlc"
          "localsend"
          "utm"
          "stats"
        ];
        masApps = {};
        onActivation.cleanup = "zap";
      };

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.open-dyslexic
      ];

      system.defaults = {
        dock.autohide  = true;
        dock.largesize = 64;
        dock.persistent-apps = [
          "${pkgs.alacritty}/Applications/Alacritty.app"
          "/Applications/zen.app"
          "/Applications/vlc.app"
          "/Applications/visual-studio-code.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
        ];
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled  = false;
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