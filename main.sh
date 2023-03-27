#!/usr/bin/bash

sudo pacman -Syu --noconfirm

yay -S ananicy-cpp ananicy-rules-git

sudo systemctl enable --now ananicy-cpp.service

systemctl status ananicy-cpp
