# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "amd_pstate.shared_mem=1" ];
  boot.kernelModules = [ "kvm-amd" "v4l2loopback" "amd-pstate" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/32522e39-f661-45e3-994e-0a3217bab3bb";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-faf04ad4-c122-41d0-b680-383b74ee8731".device = "/dev/disk/by-uuid/faf04ad4-c122-41d0-b680-383b74ee8731";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/2E51-9F95";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/db0703d9-7082-4f65-af9b-2e0303bea0ab"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
