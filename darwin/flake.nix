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

      environment.systemPackages = with pkgs;
        [
          neovim
          git
          cargo
          rustc
          libgccjit
          gccgo14
          openssl
          libxml2
          libxslt
          alacritty
          wget
          curl
          unzip
          neofetch
          obsidian
          dig
          docker
          minikube
          bitcoin
          gnupg
          trezor-agent
          lazygit
          htop
          uv
        ];

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
        masApps = {
          "Yoink" = 457622435;
        };
        onActivation.cleanup = "zap";
      };

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
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

      services.nix-daemon.enable = true;

      nix.settings.experimental-features = "nix-command flakes";

      programs.zsh.enable = true;

      system.configurationRevision = self.rev or self.dirtyRev or null;

      system.stateVersion = 4;

      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build with:
    # $ darwin-rebuild build --flake .#joaozinho
    darwinConfigurations."joaozinho" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "joaozinho";
          };
        }
      ];
    };

    darwinPackages = self.darwinConfigurations."joaozinho".pkgs;
  };
}
