#!/bin/bash

# Define the list of packages to install
pkglist=("hyprland-git" "polkit-kde-agent" "dunst" "grimblast" "rofi" "rofi-emoji" "wl-clipboard" \
"wf-recorder" "wlogout" "grimblast-git" "hyprpicker-git" "hyprpaper-git" "xdg-desktop-portal-hyprland-git" \
"ffmpegthumbnailer" "tumbler" "wtype" "colord" "imagemagick" "swaylock-effects" "qt5-wayland" "qt6-wayland" \
"ripgrep" "waybar-hyprland-git" "catppuccin-gtk-theme-mocha" "catppuccin-cursors-mocha" \
"catppuccin-mocha-grub-theme-git" "nwg-look" "cava" "pavucontrol" "ranger" "zsh" "neovim" "viewnior" \
"noise-suppression-for-voice" "thunar" "thunar-archive-plugin" "file-roller" "zsh" "oh-my-zsh-git" \
"zsh-autosuggestions" "zsh-autocomplete-git" "zsh-autoswitch-virtualenv-git" "zsh-doc" \
"zsh-history-substring-search" "btop" "sddm-git" "sddm-sugar-candy-git" "swappy" "network-manager-applet" \
"gvfs" "nvchad-git" "neofetch" "bluez" "blueman" "bluez-utils" "xorg-xhost")

# Prompt the user to install the packages
read -rp "Do you want to install the packages? [y/N]: " install_packages
if [[ $install_packages == "Y" || $install_packages == "y" ]]; then
    echo "Installing packages..."
    for pkg in "${pkglist[@]}"; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            paru -Syu "$pkg"
        else
            echo "$pkg is already installed"
        fi
    done
fi

# Prompt the user to clone the NvChad repository
read -rp "Do you want to clone the NvChad repository? [y/N]: " clone_nvchad
if [[ $clone_nvchad == "Y" || $clone_nvchad == "y" ]]; then
    echo "Cloning the NvChad repository..."
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
fi

# Define the folders and files to copy
folders_to_copy=(".cache" ".config" ".zsh" "Backgrounds" ".scripts")
files_to_copy=(".zshrc" ".p10k.zsh")

# Prompt the user to copy the folders and files
read -rp "Do you want to copy the folders and files? [y/N]: " copy_files
if [[ $copy_files == "Y" || $copy_files == "y" ]]; then
    for folder in "${folders_to_copy[@]}"; do
        echo "Copying folder: $folder"
        cp -r "$folder" ~/
    done

    for file in "${files_to_copy[@]}"; do
        echo "Copying file: $file"
        cp "$file" ~/
    done

    echo "Config files have been moved. Please restart."
fi

# Create the directory and copy the file if it doesn't exist
if [[ ! -d "/usr/share/zsh-theme-powerlevel10k" ]]; then
    echo "Creating directory: /usr/share/zsh-theme-powerlevel10k"
    sudo mkdir -p "/usr/share/zsh-theme-powerlevel10k"
fi

# Copy the powerlevel10k theme over
sudo cp -r "usr" "/"

# Disable wifi powersave mode ###
read -rp 'Would you like to disable WiFi powersave?(Y/n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "The following file has been created $LOC."
    echo -e "Restarting NetworkManager service..."
    sleep 1
    sudo systemctl restart NetworkManager
    sleep 2
fi