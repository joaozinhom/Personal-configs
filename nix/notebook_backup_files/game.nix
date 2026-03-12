{ config, pkgs, lib, ... }:
{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    steam-run
    #ryujinx
    #heroic
    # obs-studio  # uncomment if streaming
  ];
}
