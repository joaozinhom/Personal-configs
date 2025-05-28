{ config, pkgs, lib, ... }:
{
  #copy from here 
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
  # mullvad
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  services.resolved.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  services.libinput.enable = true;
  # multi-touch gesture recognizer
  services.touchegg.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #ollama
  services.ollama= {
  enable = true;
  # Optional: preload models, see https://ollama.com/library
  loadModels = [ "devstral" "qwen3"];
};


  services.udev.packages = [pkgs.vial pkgs.via];

  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  	#for code and work
	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	vial
	libgtop
	pyenv
	gparted
	minikube
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
	vivaldi
	obsidian
	libgccjit
	gccgo14
	rustc
	docker
	wavm
	unzip
	uv
	tailscale
	gtop
	obs-studio
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
	nerd-fonts._0xproto
        nerd-fonts.droid-sans-mono
	#nerd-fonts
	discord
	vlc
	steam-run
	steam
	heroic
  	ryujinx
	rpcs3
	#AI packages
	ollama
	lmstudio
  ];
}
