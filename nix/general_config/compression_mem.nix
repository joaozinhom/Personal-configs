{ config, pkgs, ... }:
{
  zramSwap = {
    enable = true;
    memoryPercent = 30;
    algorithm = "zstd";
    priority = 100;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
}
