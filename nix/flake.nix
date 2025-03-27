{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };
  outputs = { self, nixpkgs}:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      hardware = ./hardware-configuration.nix;
    in
    {

      nixosConfigurations = {
        userland = nixpkgs.lib.nixosSystem {
          modules = [
            hardware
            ./minimalist.nix
          ];
          inherit system;
        };
        backend = nixpkgs.lib.nixosSystem {
          modules = [
            hardware
            ./sanctuary.nix
          ];
          inherit system;
        };
      };
    };

  description = "No description provided!";
}