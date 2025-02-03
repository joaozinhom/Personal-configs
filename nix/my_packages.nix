  #copy from here

  #niri
  programs.niri.enable = true;
  # mullvad
  services.mullvad-vpn.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  	#for code and work
	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   	appimage-run
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
	virtualbox
	unzip
	ollama
	ollama-rocm
	#for privacy
	localsend
	sparrow
	bitcoin
	mullvad-vpn
	gnupg
	dig
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
	lutris
  ];
