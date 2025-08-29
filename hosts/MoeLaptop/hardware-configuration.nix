{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/33333333-3333-3333-3333-333333333333";
    fsType = "btrfs";
    options = [ "compress=zstd" "discard=async" "space_cache=v2" "noatime" "ssd" ];
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1111-1111";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [
    { device = "/dev/disk/by-uuid/22222222-2222-2222-2222-222222222222"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
