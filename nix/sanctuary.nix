{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #virtual box settings
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.docker.members = [ "username-with-access-to-socket" ];
   virtualisation.virtualbox.host.enableExtensionPack = true;
   virtualisation.docker.rootless = {
   enable = true;
   setSocketVariable = true;};
  #tailscale	
  services.tailscale.enable = true;
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
  services.udev.packages = [pkgs.vial pkgs.via];

  environment.systemPackages = with pkgs; [
  	#for code and work
	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	vial
	pyenv
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
	tailscale
	#for privacy
	localsend
	sparrow
	bitcoin	
	mullvad-vpn
	gnupg
	dig
	moonlight-qt	
	#for fun
	ocs-url
	lsd
	alacritty-theme
	neofetch
	nerdfonts
	discord
	spotify
	vlc
	steam-run
	steam
	heroic
  ];
}

	

	
	

