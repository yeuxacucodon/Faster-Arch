#!/usr/bin/bash

# Upgrade system
echo -e "\033[1;31mUpdating your system...\n\033[0m"
sudo pacman -Syu --noconfirm

# Choose AUR helper
echo -e "\n\033[0;32m----------------------------------\033[0m"
echo -e "\n\033[1;37mChoose your AUR helper:\n\033[0m"
echo "1. yay"
echo "2. paru"
echo "3. Exit"
echo -n -e "\nOptions: "
read choice

case $choice in
"1")
	yay -S ananicy-cpp ananicy-rules-git preload --noconfirm
	;;
"2")
	paru -S ananicy-cpp ananicy-rules-git preload --noconfirm
	;;
*)
	exit -1
	;;
esac

# Install linux-zen kernel and update GRUB
sudo pacman -S linux-zen --noconfirm
if [[ $(pacman -Q grub | cut -f 1 -d " ") == "grub" ]]; then
	echo -e "\n\033[1;31mUpdate GRUB...\n\033[0m"
	sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

# Install dbus-broker
sudo pacman -S dbus-broker --noconfirm
sudo systemctl enable --now dbus-broker.service
systemctl --user enable dbus-broker.service

# Enable preload and ananicy-cpp
sudo systemctl enable --now preload
sudo systemctl enable --now ananicy-cpp.service

# Install earlyoom
sudo pacman -S earlyoom --noconfirm
sudo systemctl enable --now earlyoom

echo -e "\n\033[1;32mFinished!\033[0m"
