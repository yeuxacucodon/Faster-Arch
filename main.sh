#!/usr/bin/bash

# Intel driver
sudo pacman -S intel-media-driver intel-media-sdk --noconfirm

# Install linux-zen kernel
if [[ $(pacman -Q grub | cut -f 1 -d " ") == "linux-zen" ]]; then
	echo -e "\n\033[1;31mInstall linux-zen...\n\033[0m"
	sudo pacman -S linux-zen --noconfirm
fi
# Update GRUB
if [[ $(pacman -Q grub | cut -f 1 -d " ") == "grub" ]]; then
	echo -e "\n\033[1;31mUpdate GRUB...\n\033[0m"
	sudo cp ./grub /etc/default/
	sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

# Install dbus-broker
sudo pacman -S dbus-broker --noconfirm
systemctl --user enable dbus-broker.service

# Install earlyoom
sudo pacman -S earlyoom --noconfirm
sudo systemctl enable --now earlyoom

sudo systemctl mask systemd-random-seed
sudo systemctl mask lvm2-monitor
sudo cp ./blacklist.conf /etc/modprobe.d/
sudo sed -E -i 's/#Storage=auto/Storage=none/' /etc/systemd/journald.conf

echo -e "\n\033[1;32mFinished! Reboot and enjoy\033[0m"
