{ config, pkgs, lib, ... }:
{
  #virtual box settings
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.docker.members = [ "joaozinho" ];
   virtualisation.virtualbox.host.enableExtensionPack = true;
   virtualisation.virtualbox.host.enableKvm = true;
   virtualisation.virtualbox.host.addNetworkInterface = false;
   virtualisation.docker.rootless = {
  	enable = true;
  	setSocketVariable = true;};

  #tailscale	
  services.tailscale.enable = true;
  virtualisation.docker.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  services.libinput.enable = true;
  # multi-touch gesture recognizer
  services.touchegg.enable = true;
  # List packages installed in system profile. To search, run:
networking.firewall.checkReversePath = false;
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
	protonvpn-gui
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
  ryujinx
	#AI packages
	ollama
	lmstudio
  ];
}
