#!/bin/bash

# Assuming that you already have internet connection

echo "select a disk for gentoo installation
(it will use 16GB of space)
!! it will wipe all data on the disk !!"

echo $(lsblk -d | tail -n+2 | cut -d" " -f1)
read disk

(
echo g # Create a new empty GPT partion
echo n # Create boot partion
echo
echo
echo   + 1024M
echo   t
echo   1
echo   n # Create main partion
echo
echo
echo  + 15360M
echo w
) | fdisk /dev/$disk

# Creating file system
mkfs.vfat -F 32 /dev/$disk\1
mkfs.ext4 /dev/$disk\2

# Mount disks
if [ -d "/mnt/gentoo" ]; then
echo ok
else
mkdir /mnt/gentoo
fi
mount /dev/$disk\2 /mnt/gentoo
mkdir /mnt/gentoo/efi
mount /dev/$disk\1 /mnt/gentoo/efi

# Download make conf and packages configs
cp -r GLmox-main /mnt/gentoo
mv /mnt/gentoo/GLmox-main/setup.sh /mnt/gentoo/setup.sh 
chmod +x /mnt/gentoo/setup.sh

# Download stage3 file [systemd, without desktop environment]
cd  /mnt/gentoo
wget  https://distfiles.gentoo.org/releases/amd64/autobuilds/20241124T163746Z/stage3-amd64-systemd-20241124T163746Z.tar.xz

# Unpack stage file
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner -C /mnt/gentoo

# Setup network on a gentoo
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

# Setup time zone
echo Select a time zone:
echo $(ls usr/share/zoneinfo)
read region
echo Now select country:
echo $(ls usr/share/zoneinfo/$region)
read country
ln -sf usr/share/zoneinfo/$region/$country etc/localtime

# Gen fstab file
genfstab -U /mnt/gentoo > etc/fstab

# Setup locales
echo en_US.UTF-8 UTF-8 >> etc/locale.gen

echo 'Now you will chroot into new environment
Execute setup.sh'
#chroot into new environment
arch-chroot /mnt/gentoo