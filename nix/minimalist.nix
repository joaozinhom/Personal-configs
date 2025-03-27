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
	curl
	git
	cargo
	vscode
	brave
	libgccjit
	gccgo14
	rustc
	nodejs_23
	unzip
	gnupg
	neofetch
	nerdfonts
	discord
	spotify
	vlc
	steam-run
	steam
  ];
