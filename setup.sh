#!/bin/bash

#This script will do all hard work left

# Locale setup
locale-gen

# Setup hostname
echo Enter hostname for the computer
read hostname
hostnamectl hostname $hostname

# Setup password
echo Enter password for root
read password
(
echo $password
echo $password
) | passwd 

# Copy configurations
cp -r GLmox/package.use /etc/portage/

# Setup license in portage
echo 'ACCEPT_LICENSE="*"' >> /etc/portage/make.conf

# Compile for a server architecture
sed 's/-O2/-march=native -O2/g' /etc/portage/make.conf

# Set grub arch
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf

# Please be patient in some cases it might take a while to compile everything up
echo Now we a ready to start long process of system compilation

# Update everything 
emerge-webrsync
emerge --verbose --update --deep --changed-use @world

# Emerge packages
emerge gentoo-kernel grub intel-microcode linux-firmware sof-firmware

# Install grub
grub-install --efi-directory=/efi
