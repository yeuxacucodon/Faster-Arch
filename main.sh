#!/usr/bin/bash

echo -e "\033[1;31mUpdating your system...\n\033[0m"

sudo pacman -Syu --noconfirm

echo -e "\n\033[0;32m----------------------------------\033[0m"

echo -e "\n\033[1;37mChoose your AUR helper:\n\033[0m"
echo "1. yay"
echo "2. paru"
echo "3. Exit"
echo -n -e "\nOptions: "
read choice

case $choice in
"1")
	yay -S ananicy-cpp ananicy-rules-git --noconfirm
	;;
"2")
	paru -S ananicy-cpp ananicy-rules-git --noconfirm
	;;
*)
	exit -1
	;;
esac

sudo systemctl enable --now ananicy-cpp.service

sudo pacman -S earlyoom --noconfirm

sudo systemctl enable --now earlyoom
