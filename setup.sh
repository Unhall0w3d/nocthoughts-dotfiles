#!/bin/bash

#                                                                
#                                                                
#    )    )    )    )    )    )    )
# ( /( ( /( ( /( ( /( ( /( ( /( ( /(
# )\()))\()))\()))\()))\()))\()))\())
#((_)\((_)\((_)\((_)\((_)\((_)\((_)\\
#####################################
#       NOC THOUGHTS BLOG           #
#    https://www.nocthoughts.com    #
#####################################
# Relevant Post: https://nocthoughts.com/2023/05/29/nocthoughts-dot-files-for-hyprland.html
# GitHub: https://github.com/UnHall0w3d
# Blog: https://nocthoughts.com

# Colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"

echo -e "$CWR - Understand that this is intended to be run on a "Minimal" Arch Install."
echo -e "$CWR - Understand that editing the script to meet your purposes means it's *your* problem, but is also probably best to tailor the installed packages to your needs."
echo -e "$CWR - Also understand that, although this was made available to others, it is first and foremost intended for me."
echo -e "$CWR - As such, I will not be held responsible for your issues after running this script. Your petunia's getting dug up by the squirrels is *not* my fault."
echo -e "$COK - Now that that's out of the way..."
read -rp "Are you willing to proceed?[y/N]: " start
if ! [[ $start == "Y" || $start == "y" ]]; then
    exit
fi

# Prompt the user to install the script requirements
read -rp "Do you want to install the script requirements (paru)? [y/N]: " script_reqs
if [[ $script_reqs == "Y" || $script_reqs == "y" ]]; then
    echo -e "$CNT - Installing packages... "
    ISPARU=/usr/bin/paru
    if [ -f "$ISPARU" ]; then
      echo -e "$COK - Paru is installed. Moving on... " 
    else
      echo -e "$CWR - Paru is NOT installed. Installing... " 
      git clone https://aur.archlinux.org/paru-git.git
      cd paru-git 
      makepkg -si --noconfirm
      cd .. 
    fi
fi

# Prompt the user to install the packages
read -rp "Do you want to install the required packages? [y/N]: " install_packages
if [[ $install_packages == "Y" || $install_packages == "y" ]]; then
    echo -e "$CWR - ONLY SAY "N" IF YOU DON'T HAVE THEM ALREADY."
    read -rp "Do you need to set up the Arcolinux Repos? [y/N]: " arco
    if [[ $arco == "Y" || $arco == "y" ]]; then
        echo -e "$CNT - Updating /etc/pacman.conf to include arcolinux repositories... "
        # Add repository configurations to pacman.conf
        sudo bash -c 'echo -e "[arcolinux_repo_testing]\nSigLevel = Optional TrustedOnly\nInclude = /etc/pacman.d/arcolinux-mirrorlist\n" >> /etc/pacman.conf'
        sudo bash -c 'echo -e "[arcolinux_repo]\nSigLevel = Optional TrustedOnly\nInclude = /etc/pacman.d/arcolinux-mirrorlist\n" >> /etc/pacman.conf'
        sudo bash -c 'echo -e "[arcolinux_repo_3party]\nSigLevel = Optional TrustedOnly\nInclude = /etc/pacman.d/arcolinux-mirrorlist\n" >> /etc/pacman.conf'
        sudo bash -c 'echo -e "[arcolinux_repo_xlarge]\nSigLevel = Optional TrustedOnly\nInclude = /etc/pacman.d/arcolinux-mirrorlist\n" >> /etc/pacman.conf'
        # Move mirrorlist files to their proper location
        echo -e "$CNT - Placing mirrorlists... "
        sudo cp ./etc/pacman.d/arcolinux-mirrorlist /etc/pacman.d/
        sudo chmod +x ./.scripts/arco_keys
        sh ./.scripts/arco_keys
    else
        echo -e "$CNT - Arcolinux Repos in place, or skipped"
    fi

    # Update Paru databases
    echo -e "$CNT - Updating Paru databases... " 
    paru -Syy

    # Installing Core Components
    echo -e "$CNT - Installing main components... " 
    for pkg in hyprland wezterm swww eww-wayland rofi rofi-emoji mako xdg-desktop-portal-hyprland swappy grimblast-git slurp python xorg-xauth xorg-xhost xorg-xwayland; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg... " 
            paru -S --needed --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done
    
    # Installing Utilities
    echo -e "$CNT - Installing utilities... " 
    for pkg in exa mailspring krita eww-wayland gtk gtk2 gtk3 gtk4 ruby htop materia-transparent-gtk-theme-git socat mpvpaper inotify-tools webkit2gtk webkit2gtk-4.1 webkit2gtk-5.0 qemu-full dnsmasq virt-viewer virt-manager libvirtd vlc bat brave-bin qt5-styleplugins qt5ct archlinux-tweak-tool-git mpv wget curl polkit polkit-gnome pavucontrol-qt pamixer pipewire pipewire-audio pipewire-jack pipewire-pulse lib32-pipewire lib32-libpipewire jack wireplumber brightnessctl bluez bluez-utils blueman blueberry network-manager-applet gvfs stacer thunar thunar-archive-plugin thunar-shares-plugin thunar-vcs-plugin thunar-volman file-roller neofetch neovim ranger fnm noise-suppression-for-voice viewnior cava ripgrep ffmpegthumbnailer btop dunst wl-clipboard wf-recorder hyprpicker-git hyprpaper-git tumbler imagemagick ncspot spotify-tui pix; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg... " 
            paru -S --needed --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done

    # Installing ZSH and related plugins
    echo -e "$CNT - Installing zsh, plugins... " 
    for pkg in zsh oh-my-zsh-git zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete-git zsh-autoswitch-virtualenv-git zsh-doc zsh-history-substring-search; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg... " 
            paru -S --needed --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done

    # Installing theme utilities, themes, icons, fonts
    echo -e "$CNT - Installing themes, theme utilities... " 
    for pkg in qt5-base qt5-declarative qt5-graphcaleffects qt5-imageformats qt5-location qt5-multimedia qt5-quickcontrols qt5-quickcontrols2 qt5-speech qt5-styleplugins qt5-svg qt5-tools qt5-translations qt5-virtualkeyboard qt5-wayland qt5-webchannel qt5-webengine qt5-x11extras tela-circle-icon-theme-black wtype colord qt5-wayland qt6-wayland graphite-cursor-theme-git graphite-gtk-theme-git graphite nwg-look xfce4-settings gtklock greetd greetd-tuigreet lxappearance; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg... " 
            paru -S --needed --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done

    # Install Python Module - Requests. Required for weather display on Waybar.
    echo -e "$CNT - Installing python module 'requests' via pip... "
    pip install requests
fi

# Prompt the user to clone the NvChad repository
read -rp "Do you want to clone the NvChad repository? [y/N]: " clone_nvchad
if [[ $clone_nvchad == "Y" || $clone_nvchad == "y" ]]; then
    echo -e "$CNT - Cloning the NvChad repository... " 
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 
fi

# Prompt the user to download NerdFonts/CascadiaCode
read -rp "Do you want to download and install Fonts? I don't recommend skipping this. [y/N]: " nerdfont
if [[ $nerdfont == "Y" || $nerdfont == "y" ]]; then
    paru -S --needed --noconfirm adobe-source-sans-fonts nerd-fonts-source-code-pro ttf-fira-mono ttf-font-awesome ttf-meslo-nerd-font-powerlevel10k ttf-ms-fonts ttf-nerd-fonts-symbols-mono ttf-roboto-mono ttf-jetbrains-mono ttf-iosevka-nerd ttf-fira-sans ttf-nerd-fonts-symbols
    sleep 5
fi

# Define the folders and files to copy
folders_to_copy=(".scripts" ".config" ".zsh" "Wallpapers" ".cache")
files_to_copy=(".zshenv" ".p10*", ".profile")

# Prompt the user to copy the folders and files
read -rp "Do you want to copy the folders and config files? [y/N]: " copy_files
if [[ $copy_files == "Y" || $copy_files == "y" ]]; then
    for folder in "${folders_to_copy[@]}"; do
        echo -e "$CNT - Copying folder $folder... "
        sudo cp -r "$folder" $HOME
        sudo chown -R $USER $HOME/$folder
    done

    for file in "${files_to_copy[@]}"; do
        echo -e "$CNT - Copying file $file... " 
        cp "$file" $HOME
        sudo chown $USER $HOME/$file
    done
    echo -e "$CNT - Copying file .gtkrc-2.0 to $HOME"
    cp .p10k.zsh ~/
    cp .gtkrc-2.0 $HOME/.gtkrc-2.0
    echo -e "$CNT - Config files have been moved... "
    echo -e "$CNT - Setting File Permissions... "
    # Set Scripts Executable
    echo -e "$CNT - Setting scripts to executable... " 
    sudo chmod +x $HOME/.scripts/*

fi

# Copy the powerlevel10k theme over
echo -e "$CNT - Copying powerlevel10k theme over... " 
sudo cp -r "usr" "/" 

# Disable Wifi Powersave mode
read -rp 'Would you like to disable WiFi powersave?[y/N] ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "$CNT - The following file has been created $LOC." 
    echo -e $CAT "Restarting NetworkManager service... " 
    sleep 1
    sudo systemctl restart NetworkManager 
    sleep 2
    echo -e "$COK - NetworkManager restarted successfully." 
fi

# Setup greetd
echo -e "$CNT - Setting up greetd"
greet="/etc/greetd/"
if [ ! -d "$greet" ]; then
    sudo mkdir "$greet"
fi
sudo cp ./etc/greetd/config.toml /etc/greetd/
sudo systemctl enable greetd
sleep 2
echo -e "$OK - Greetd started successfully."

# Looking Glass
echo -e "$CNT - Setting up Looking Glass ISHVMEM file... "
lookingglass="/etc/tmpfiles.d/"
if [ ! -d "$lookingglass" ]; then
    sudo mkdir "$lookingglass"
fi
sudo cp ./etc/tmpfiles.d/10-looking-glass.conf /etc/tmpfiles.d/
echo -e "$CNT - File managed through /etc/tmpfiles.d/10-looking-glass.conf ."

# Enable Services
echo -e "$CNT - Starting Bluetooth Services... " 
sudo systemctl enable --now bluetooth.service 
sleep 2
echo -e "$COK - Bluetooth started successfully."
echo -e "$CNT - Removing conflicting XDG Portals... "
paru -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-desktop-portal-kde 

# Reset Font Cache
echo -e "$CNT - Rebuilding font cache... " 
fc-cache -f -v 
echo -e "$COK - Font cache rebuilt." 

# Setting shell to zsh
echo -e "$CNT - Changing shell to zsh (/bin/zsh)"
sudo chsh $USER -s $(which zsh)

# Script Complete
echo -e "$COK - Script Completed!" 
read -rp "Ready to Get Hypr?[y/N]: " Hypr
if [[ $Hypr == "Y" || $Hypr == "y" ]]; then
    echo -e "$COK - System is going down for a reboot... Get Hypr!"
    sleep 5
    sudo shutdown -r 0
else
  exit
fi
