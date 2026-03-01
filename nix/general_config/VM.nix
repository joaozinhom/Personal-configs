{ config, pkgs, lib, ... }:
{
  # VirtualBox configuration
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
    enableKvm = true;
    addNetworkInterface = false;
  };

  # Docker rootless mode
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Add user to docker group
  users.extraGroups.docker.members = [ "joaozinho" ];
}
