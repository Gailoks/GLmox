#!/bin/bash

#This script will do all hard work left

# Locale setup
locale-gen

# Setup hostname
echo Enter hostname for the computer
read hostname
hostnamectl hostname $hostname

# Copy configurations
cp -r /GLmox/package.use /etc/portage/

# Setup license in portage
echo 'ACCEPT_LICENSE="*"' >> /etc/portage/make.conf

# Compile for a server architecture
sed 's/-O2/-march=native -O2/g' /etc/portage/make.conf

# Set grub arch
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf

# Update everything 
emerge-webrsync
emerge --verbose --update --deep --changed-use @world

# Emerge packages
echo Now we a ready to start long process of system compilation
emerge gentoo-kernel grub

# Install grub
grub-install --efi-directory=/efi
