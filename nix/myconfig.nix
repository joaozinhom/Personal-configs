
#if you want balena etcher try the following command
#NIXPKGS_ALLOW_INSECURE=1 nix run github:nixos/nixpkgs/nixos-20.09#etcher --impure
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
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  	#for code and work
	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	gparted
	minikube
	okular
	pkg-config
	openssl
	libxml2
	libxslt
	appimage-run
	poetry
	python313
	wget
	wavm
	curl
    alacritty
	neovim
	git
	cargo
	vscode
	zed-editor
	chromium
	brave
	obsidian
	libgccjit
	gccgo14
	rustc
	nodejs_23
	docker
	wavm
	unzip
	ollama
	ollama-rocm
	uv
	#for privacy
	localsend
	sparrow
	bitcoin
	mullvad-vpn
	gnupg
	dig
	#for fun
	lsd
	neofetch
	nerdfonts
	discord
	spotify
	vlc
	steam-run
	steam
	heroic
  ];
