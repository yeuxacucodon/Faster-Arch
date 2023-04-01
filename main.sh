#!/usr/bin/bash

echo -e "Choose your AUR helper\n"
echo "1. yay"
echo "2. paru"
echo "3. Exit"
echo -n -e "\nOptions: "
read choice

case $choice in
"1")
	yay -S ananicy-cpp ananicy-rules-git
	;;
"2")
	paru -S ananicy-cpp ananicy-rules-git
	;;
*)
	exit -1
	;;
esac

sudo systemctl enable --now ananicy-cpp.service

systemctl status ananicy-cpp
