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

# Log File
LOG="install.log"

# Prompt the user to install the script requirements
read -rp "Do you want to install the script requirements (paru)? [y/N]: " script_reqs
if [[ $script_reqs == "Y" || $script_reqs == "y" ]]; then
    echo -e "$CNT - Installing packages..."
    ISPARU=/usr/bin/paru
    if [ -f "$ISPARU" ]; then
      echo -e "$COK - Paru is installed. Moving on..." &>> $LOG
    else
      echo -e "$CWR - Paru is NOT installed. Installing... " &>> $LOG
      git clone https://aur.archlinux.org/paru-git.git &>> $LOG
      cd paru-git &>> $LOG
      makepkg -si --noconfirm &>> ../$LOG
      cd ..
    fi
fi

# Prompt the user to install the packages
read -rp "Do you want to install the packages? [y/N]: " install_packages
if [[ $install_packages == "Y" || $install_packages == "y" ]]; then
    echo -e "$CNT - Updating Paru databases... " &>> $LOG
    paru -Syu --noconfirm &>> $LOG
    echo -e "$CNT - Installing Waybar..." &>> $LOG
    paru -S --noconfirm gcc12 &>> $LOG
    export CC=gcc-12 CXX=g++-12
    paru -S --noconfirm waybar-hyprland-git &>> $LOG
    echo -e "$CNT - Waybar installed."
    echo -e "$CNT - Installing main components..." &>> $LOG
    for pkg in hyprland-git wezterm swaylock-effects wofi wlogout rofi rofi-emoji mako xdg-desktop-portal-hyprland-git swappy grimblast-git slurp thunar xorg-xhost; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg..." &>> $LOG
            paru -Sy "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" &>> $LOG
        fi
    done
    echo -e "$CNT - Installing utilities..." &>> $LOG
    for pkg in polkit-gnome pavucontrol brightnessctl bluez bluez-utils blueman network-manager-applet gvfs thunar-archive-plugin file-roller neofetch neovim ranger fnm noise-suppression-for-voice viewnior cava ripgrep ffmpegthumbnailer btop dunst wl-clipboard wf-recorder hyprpicker-git hyprpaper-git tumbler imagemagick ncspot pix; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg..." &>> $LOG
            paru -Sy --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" &>> $LOG
        fi
    done
    echo -e "$CNT - Installing zsh, plugins..." &>> $LOG
    for pkg in zsh oh-my-zsh-git zsh-autosuggestions zsh-autocomplete-git zsh-autoswitch-virtualenv-git zsh-doc zsh-history-substring-search; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg..." &>> $LOG
            paru -Sy --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" &>> $LOG
        fi
    done
    echo -e "$CNT - Installing themes, theme utilities..." &>> $LOG
    for pkg in wtype colord qt5-wayland qt6-wayland sweet-cursors-theme-git sweet-folders-icons-git sweet-gtk-theme-dark sweet-kvantum-theme kvantum nwg-look xfce4-settings ttf-cascadia-code-nerd sddm-git sddm-sugar-candy-git lxappearance; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg..." &>> $LOG
            paru -Sy --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" &>> $LOG
        fi
    done
fi

# Prompt the user to clone the NvChad repository
read -rp "Do you want to clone the NvChad repository? [y/N]: " clone_nvchad
if [[ $clone_nvchad == "Y" || $clone_nvchad == "y" ]]; then
    echo -e "$CNT - Cloning the NvChad repository..." &>> $LOG
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 &>> $LOG
fi

# Define the folders and files to copy
folders_to_copy=(".cache" ".config" ".zsh" "Backgrounds" ".scripts")
files_to_copy=(".zshrc" ".p10k.zsh")

# Prompt the user to copy the folders and files
read -rp "Do you want to copy the folders and files? [y/N]: " copy_files
if [[ $copy_files == "Y" || $copy_files == "y" ]]; then
    for folder in "${folders_to_copy[@]}"; do
        echo -e "$CNT - Copying folder $folder..." &>> $LOG
        cp -r "$folder" ~/ &>> $LOG
    done

    for file in "${files_to_copy[@]}"; do
        echo -e "$CNT - Copying file $file..." &>> $LOG
        cp "$file" ~/ &>> $LOG
    done

    echo -e "$CNT - Config files have been moved." &>> $LOG
fi

# Copy the powerlevel10k theme over
echo -e "$CNT - Copying powerlevel10k theme over..." &>> $LOG
sudo cp -r "usr" "/" &>> $LOG

# Disable Wifi Powersave mode
read -rp 'Would you like to disable WiFi powersave?(Y/n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "$CNT - The following file has been created $LOC." &>> $LOG
    echo -e $CAT "Restarting NetworkManager service..." &>> $LOG
    sleep 1
    sudo systemctl restart NetworkManager &>> $LOG
    sleep 2
    echo -e "$COK - NetworkManager restarted successfully." &>> $LOG
fi

# Enable Services
echo -e "$CNT - Starting Bluetooth Services..." &>> $LOG
sudo systemctl enable --now bluetooth.service &>> $LOG
sleep 2
echo -e "$COK - Bluetooth started successfully." &>> $LOG
echo -e "$CNT - Starting SDDM Services..." &>> $LOG
sudo systemctl enable --now sddm &>> $LOG
sleep 2
echo -e "$COK - SDDM started successfully." &>> $LOG
echo -e "$CNT - Removing conflicting XDG Portals... "
paru -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-desktop-portal-kde &>> $LOG

# Reset Font Cache
echo -e "$CNT - Rebuilding font cache..." &>> $LOG
sudo fc-cache -f -v &>> $LOG
echo -e "$COK - Font cache rebuilt." &>> $LOG

# Set Scripts Executable
echo -e "$CNT - Setting scripts to executable..." &>> $LOG
sudo chmod +x ~/.scripts/colorpicker &>> $LOG
sudo chmod +x ~/.scripts/IOMMU.sh &>> $LOG
sudo chmod +x ~/.scripts/screensht &>> $LOG
sudo chmod +x ~/.scripts/xhost.sh &>> $LOG

# Setup SDDM Theme
echo -e "$CNT - Setting up the login screen..." &>> $LOG
sudo cp -R sddm_theme /usr/share/sddm/themes/ &>> $LOG
sudo chown -R $USER:$USER /usr/share/sddm/themes/sddm_theme &>> $LOG
sudo mkdir /etc/sddm.conf.d &>> $LOG
echo -e "[Theme]\nCurrent=sdt" | sudo tee -a /etc/sddm.conf.d/10-theme.conf &>> $LOG
WLDIR=/usr/share/wayland-sessions
if [ -d "$WLDIR" ]; then
    echo -e "$COK - $WLDIR found..." &>> $LOG
else
    echo -e "$CWR - $WLDIR NOT found, creating..." &>> $LOG
    sudo mkdir $WLDIR &>> $LOG
fi
sudo cp hyprland.desktop /usr/share/wayland-sessions/ &>> $LOG
sudo sudo sed -i 's/Exec=Hyprland/Exec=\/home\/'$USER'\/start_hyprland/' /usr/share/wayland-sessions/hyprland.desktop &>> $LOG
cp start_hyprland ~/ &>> $LOG

# Setup some theme settings
xfconf-query -c xsettings -p /Net/ThemeName -s "Sweet-Dark" &>> $LOG
xfconf-query -c xsettings -p /Net/IconThemeName -s "Sweet-Dark" &>> $LOG
gsettings set org.gnome.desktop.interface gtk-theme "Sweet-Dark" &>> $LOG
gsettings set org.gnome.desktop.interface icon-theme "Sweet-Dark" &>> $LOG
ln -sf /usr/share/sddm/themes/sddm_theme/Backgrounds/wallpaper-dark.jpg /usr/share/sddm/themes/sddm_theme/wallpaper.jpg &>> $LOG

# Script Complete
echo -e "$COK - Script Completed!" &>> $LOG
read -rp "Ready to get Hypr?(Y/n): " Hypr
if [[ $Hypr == "Y" || $Hypr == "y" ]]; then
  exec sudo systemctl start sddm &>> $LOG
else
  exit
fi