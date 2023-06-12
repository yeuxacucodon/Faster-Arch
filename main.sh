#!/usr/bin/bash

# Choose AUR helper
echo -e "\n\033[1;37mChoose your AUR helper:\n\033[0m"
echo "1. yay"
echo "2. paru"
echo "3. Exit"
echo -n -e "\nOptions: "
read choice

# Install ananicy
echo -e "\033[0;32mInstalling ananicy-cpp...\033[0m"
case $choice in
"1")
	yay -S ananicy-cpp-git ananicy-rules-git --noconfirm
	;;
"2")
	paru -S ananicy-cpp-git ananicy-rules-git --noconfirm
	;;
*)
	exit -1
	;;
esac

echo -n -e "\n\033[0;32mDo you want to install intel-media-sdk and intel-media-driver? (y/n): \033[0m"
read choice

if [[ $choice == 'y' ]]; then
	sudo pacman -S intel-media-driver intel-media-sdk --noconfirm
fi

# Install linux-zen kernel and update GRUB
sudo pacman -S linux-zen --noconfirm
if [[ $(pacman -Q grub | cut -f 1 -d " ") == "grub" ]]; then
	echo -e "\n\033[1;31mUpdate GRUB...\n\033[0m"
	sudo cp ./grub /etc/default/
	sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

# Install dbus-broker
sudo pacman -S dbus-broker --noconfirm
systemctl --user enable dbus-broker.service

# Enable ananicy-cpp
sudo systemctl enable --now ananicy-cpp.service

# Install earlyoom
sudo pacman -S earlyoom --noconfirm
sudo systemctl enable --now earlyoom

sudo systemctl mask systemd-random-seed
sudo systemctl mask lvm2-monitor
sudo cp ./blacklist.conf /etc/modprobe.d/
sudo sed -E -i 's/#Storage=auto/Storage=none/' /etc/systemd/journald.conf

echo -e "\n\033[1;32mFinished! Reboot and enjoy\033[0m"
