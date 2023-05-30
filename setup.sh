#!/bin/bash
#####################################
# Script created by Ken Perry, 2023 #
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

# Prompt the user to install the script requirements
read -rp "Do you want to install the script requirements (paru)? [y/N]: " script_reqs
if [[ $script_reqs == "Y" || $script_reqs == "y" ]]; then
    echo -e "$CNT - Installing packages..."
    ISPARU=/usr/bin/paru
    if [ -f "$ISPARU" ]; then
      echo -e "$COK - Paru is installed. Moving on..." 
    else
      echo -e "$CWR - Paru is NOT installed. Installing... " 
      git clone https://aur.archlinux.org/paru-git.git
      cd paru-git 
      makepkg -si --noconfirm
      cd .. 
    fi
fi

# Prompt the user to install the packages
read -rp "Do you want to install the packages? [y/N]: " install_packages
if [[ $install_packages == "Y" || $install_packages == "y" ]]; then
    echo -e "$CNT - Updating Paru databases... " 
    paru -Syu --noconfirm
    echo -e "$CNT - Installing Waybar..." 
    paru -S --noconfirm gcc12
    export CC=gcc-12 CXX=g++-12
    paru -S --noconfirm waybar-hyprland-git 
    echo -e "$CNT - Waybar installed."
    echo -e "$CNT - Installing main components..." 
    for pkg in hyprland-git wezterm swaylock-effects wofi wlogout rofi rofi-emoji mako xdg-desktop-portal-hyprland-git swappy grimblast-git slurp thunar xorg-xhost; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg..." 
            paru -Sy --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done
    echo -e "$CNT - Installing utilities..." 
    for pkg in polkit-gnome pavucontrol brightnessctl bluez bluez-utils blueman network-manager-applet gvfs thunar-archive-plugin file-roller neofetch neovim ranger fnm noise-suppression-for-voice viewnior cava ripgrep ffmpegthumbnailer btop dunst wl-clipboard wf-recorder hyprpicker-git hyprpaper-git tumbler imagemagick ncspot pix; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg..." 
            paru -Sy --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done
    echo -e "$CNT - Installing zsh, plugins..." 
    for pkg in zsh oh-my-zsh-git zsh-autosuggestions zsh-autocomplete-git zsh-autoswitch-virtualenv-git zsh-doc zsh-history-substring-search; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg..." 
            paru -Sy --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done
    echo -e "$CNT - Installing themes, theme utilities..." 
    for pkg in wtype colord qt5-wayland qt6-wayland sweet-cursors-theme-git sweet-folders-icons-git sweet-gtk-theme-dark sweet-kvantum-theme kvantum nwg-look xfce4-settings ttf-cascadia-code-nerd sddm-git sddm-sugar-candy-git lxappearance; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg..." 
            paru -Sy --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done
fi

# Prompt the user to clone the NvChad repository
read -rp "Do you want to clone the NvChad repository? [y/N]: " clone_nvchad
if [[ $clone_nvchad == "Y" || $clone_nvchad == "y" ]]; then
    echo -e "$CNT - Cloning the NvChad repository..." 
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 
fi

# Define the folders and files to copy
folders_to_copy=(".cache" ".config" ".zsh" "Backgrounds" ".scripts")
files_to_copy=(".zshrc" ".p10k.zsh")

# Prompt the user to copy the folders and files
read -rp "Do you want to copy the folders and files? [y/N]: " copy_files
if [[ $copy_files == "Y" || $copy_files == "y" ]]; then
    for folder in "${folders_to_copy[@]}"; do
        echo -e "$CNT - Copying folder $folder..." 
        cp -r "$folder" ~/ 
    done

    for file in "${files_to_copy[@]}"; do
        echo -e "$CNT - Copying file $file..." 
        cp "$file" ~/ 
    done

    echo -e "$CNT - Config files have been moved." 
fi

# Copy the powerlevel10k theme over
echo -e "$CNT - Copying powerlevel10k theme over..." 
sudo cp -r "usr" "/" 

# Disable Wifi Powersave mode
read -rp 'Would you like to disable WiFi powersave?(Y/n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "$CNT - The following file has been created $LOC." 
    echo -e $CAT "Restarting NetworkManager service..." 
    sleep 1
    sudo systemctl restart NetworkManager 
    sleep 2
    echo -e "$COK - NetworkManager restarted successfully." 
fi

# Enable Services
echo -e "$CNT - Starting Bluetooth Services..." 
sudo systemctl enable --now bluetooth.service 
sleep 2
echo -e "$COK - Bluetooth started successfully." 
echo -e "$CNT - Starting SDDM Services..." 
sudo systemctl enable sddm 
sleep 2
echo -e "$COK - SDDM started successfully." 
echo -e "$CNT - Removing conflicting XDG Portals... "
paru -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-desktop-portal-kde 

# Reset Font Cache
echo -e "$CNT - Rebuilding font cache..." 
sudo fc-cache -f -v 
echo -e "$COK - Font cache rebuilt." 

# Set Scripts Executable
echo -e "$CNT - Setting scripts to executable..." 
sudo chmod +x ~/.scripts/colorpicker 
sudo chmod +x ~/.scripts/IOMMU.sh 
sudo chmod +x ~/.scripts/screensht
sudo chmod +x ~/.scripts/xhost.sh

# Setup SDDM Theme
echo -e "$CNT - Setting up the login screen..." 
sudo cp -R sddm_theme /usr/share/sddm/themes/ 
sudo chown -R $USER:$USER /usr/share/sddm/themes/sddm_theme 
sudo mkdir /etc/sddm.conf.d 
echo -e "[Theme]\nCurrent=sdt" | sudo tee -a /etc/sddm.conf.d/10-theme.conf
WLDIR=/usr/share/wayland-sessions
if [ -d "$WLDIR" ]; then
    echo -e "$COK - $WLDIR found..." 
else
    echo -e "$CWR - $WLDIR NOT found, creating..." 
    sudo mkdir $WLDIR 
fi
sudo cp hyprland.desktop /usr/share/wayland-sessions/  
sudo sudo sed -i 's/Exec=Hyprland/Exec=\/home\/'$USER'\/start_hyprland/' /usr/share/wayland-sessions/hyprland.desktop 
cp start_hyprland ~/ 

# Setup some theme settings
xfconf-query -c xsettings -p /Net/ThemeName -s "Sweet-Dark"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Sweet-Dark"
gsettings set org.gnome.desktop.interface gtk-theme "Sweet-Dark"
gsettings set org.gnome.desktop.interface icon-theme "Sweet-Dark"
sudo ln -sf /usr/share/sddm/themes/sddm_theme/Backgrounds/wallpaper-dark.jpg /usr/share/sddm/themes/sddm_theme/wallpaper.jpg

# Script Complete
echo -e "$COK - Script Completed!" 
read -rp "Ready to get Hypr?(Y/n): " Hypr
if [[ $Hypr == "Y" || $Hypr == "y" ]]; then
  exec sudo systemctl start sddm 
else
  exit
fi