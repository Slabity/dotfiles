# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
  boot.blacklistedKernelModules = [ "radeon" ];
  boot.extraModulePackages = [ ];
  boot.extraModprobeConfig = "options vfio-pci ids=1002:67b1,1002:aac8";
  boot.kernelParams = [
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/f59a5540-ed45-4841-a657-b6d8b063716d";
      fsType = "btrfs";
      options = [ "subvol=system" ];
    };

  boot.initrd.luks.devices."raichu".device = "/dev/disk/by-uuid/2de91767-7c9c-4797-b68f-9489e61cac5c";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/CDEE-8363";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/2c19c216-2303-44a3-a0c3-1104c9f2b2c9";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;
}
