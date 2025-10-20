{ config, pkgs, lib, ... }:
{
  #copy from here
  #virtual box settings
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.docker.members = [ "joaozinho" ];
   virtualisation.virtualbox.host.enableExtensionPack = true;
   virtualisation.virtualbox.host.enableKvm = true;
   virtualisation.virtualbox.host.addNetworkInterface = false;
   virtualisation.docker.rootless = {
  	enable = true;
  	setSocketVariable = true;};
environment.variables = {
GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
};
  programs.gnupg.agent.enable = true;
  users.users.joaozinho.extraGroups = [ "dialout" ];
  #tailscale	
  services.tailscale.enable = true;
  virtualisation.docker.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  services.libinput.enable = true;
  # multi-touch gesture recognizer
  services.touchegg.enable = true;
  #flatpak enable
  services.flatpak.enable = true;
  # List packages installed in system profile. To search, run:
  networking.firewall.checkReversePath = false;
  # $ nix search wget
  services.udev.packages = [pkgs.vial pkgs.via];

  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #flatpak
  	flatpak
      	gnome-software
  	#for code and work	
	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	vial
	libgtop
	gparted
	minikube
	pkg-config
	openssl
	libxml2
	libxslt
	appimage-run
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
	tailscale
	obs-studio
	#for privacy
	localsend
	sparrow
	bitcoin	
	protonvpn-gui
	gnupg
	dig
	#for fun
	neofetch
	#nerd-fonts
	vlc
	steam-run
	steam
  	ryujinx
	#AI packages
	lmstudio
  ];
}