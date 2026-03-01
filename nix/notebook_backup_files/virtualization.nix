{ config, pkgs, lib, ... }:
{
  # Enable libvirtd for VM management
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;         # TPM emulation (needed for Windows 11)
      ovmf = {
        enable = true;             # UEFI support
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  # Enable virt-manager and GNOME Boxes support
  programs.virt-manager.enable = true;

  # Add user to required groups
  users.users.joaozinho.extraGroups = [ "libvirtd" "kvm" ];

  # Packages
  environment.systemPackages = with pkgs; [
    gnome-boxes      # Simple, easy-to-use VM app (like you asked)
    virt-manager     # Advanced VM manager (bonus)
    virt-viewer      # Remote viewer for VMs
    spice-gtk        # SPICE protocol support (clipboard sharing, display)
    win-virtio       # VirtIO drivers for Windows guests
  ];

  # Enable SPICE USB redirection
  virtualisation.spiceUSBRedirection.enable = true;
}
