{ config, pkgs, lib, ... }:

{
  imports = [ (import <nix-snapd>).nixosModules.default ];

  services.snap.enable = true;
}

