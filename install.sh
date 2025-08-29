#!/usr/bin/env bash

DISK=/dev/nvme0n1
DISK_EFI=/dev/nvme0n1p1
DISK_ROOT=/dev/nvme0n1p2

continueFunc() {
  while :; do
    read -p "Continue? (y/n): " continueAnswer
    case "$continueAnswer" in
      Y|y)
        return 0
        ;;
      N|n)
        return 1
        ;;
      *)
        echo "Incorrect value: Enter y or n!"
        ;;
    esac
  done
}

diskSetup() {
  continueFunc
  
  sgdisk --zap-all $DISK
  sgdisk --new=1:0:+512M --typecode=1:EF00 --change-name=1:EFI $DISK
  sgdisk --new=2:0:0 --typecode=2:8300 --change-name=2:ROOT $DISK

  mkfs.fat -F32 -n EFI -i 11111111 $DISK_EFI
  mkfs.btrfs -f -U 11111111-1111-1111-1111-111111111111 $DISK_ROOT

  mount $DISK_ROOT /mnt
  mkdir -p /mnt/boot/efi
  mount $DISK_EFI /mnt/boot/efi
  mkdir /mnt/etc/nixos
}

nixosInstall() {
  cp ../* /mnt/etc/nixos
  nixos-install --flake /mnt/etc/nixos#MoeOS
}

while :; do
  clear
  echo -e "Chose host:\n1) MoeLaptop\nq) quit\n"
  read hostname
  case "$hostname" in
    1)
      echo "You chose MoeLaptop, contunue? (y/n): "
      continueFunc
      diskSetup
      nixosInstall
      ;;
    q)
      exit
      ;;
    *)
      echo "Incorrect value: Try again!"
  esac
done
