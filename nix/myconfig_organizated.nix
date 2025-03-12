  #copy from here
  #virtual box settings
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.docker.members = [ "username-with-access-to-socket" ];
   virtualisation.virtualbox.host.enableExtensionPack = true;
   virtualisation.docker.rootless = {
  	enable = true;
  	setSocketVariable = true;};

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;

  virtualisation.docker.enable = true;
  #niri
  programs.niri.enable = true;
  # mullvad
  services.mullvad-vpn.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  services.libinput.enable = true;
  # multi-touch gesture recognizer
  services.touchegg.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #!!!text editors/dev tools
    neovim
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    minikube
    openssl
    libxml2
    libxslt
    git
    wget
    vscode
    zed-editor
    chromium
    #!!!Programming languages and managers
    uv
    cargo
    python313
    libgccjit
    gccgo14
    rustc
    nodejs_23
    #!!!system and linux tools
    alacritty
    gparted
    okular
    pkg-config
    appimage-run
    wavm
    curl
    obsidian
    docker
    wavm
    ollama
    ollama-rocm
    unzip
    dig
    #for privacy
    localsend
    sparrow
    bitcoin
    mullvad-vpn
    gnupg
    #!!!entertainment and social life
    steam-run
    steam
    heroic
    discord
    spotify
    neofetch
    nerdfonts
    lsd
    vlc
    brave
  ];
	

	
	

