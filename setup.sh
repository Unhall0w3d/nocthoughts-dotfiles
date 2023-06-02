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
    paru -Sy

    # Install Waybar
    echo -e "$CNT - Installing Waybar... " 
    paru -S --needed --noconfirm gcc12
    export CC=gcc-12 CXX=g++-12
    paru -S --needed --noconfirm waybar-hyprland-git 
    echo -e "$CNT - Waybar installed."

    # Installing Core Components
    echo -e "$CNT - Installing main components... " 
    for pkg in hyprland-dev wezterm swaylock-effects swaybg wofi wlogout rofi rofi-emoji mako xdg-desktop-portal-hyprland swappy grimblast-git slurp thunar xorg-xhost python python-pip python-pyxdg xorg-bdftopcf xorg-fonts-encodings xorg-iceauth xorg-mkfontscale xorg-server xorg-server-common xorg-sessreg xorg-setxkbmap xorg-smproxy xorg-x11perf xorg-xauth xorg-xbacklight xorg-xcmsdb xorg-xcursorgen xorg-xdpyinfo xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost xorg-xinit xorg-xinput xorg-xkbcomp xorg-xkbevd xorg-xkbprint xorg-xkbutils xorg-xkill xorg-xlsatoms xorg-xlsclients xorg-xmodmap xorg-xpr xorg-xprop xorg-xrandr xorg-xrdb xorg-refresh xorg-xset xorg-xsetroot xorg-xvinfo xorg-xwayland xorg-xwd xorg-xwininfo xorg-xwud xorgproto; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg... " 
            paru -Sy --needed --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done
    
    # Installing Utilities
    echo -e "$CNT - Installing utilities... " 
    for pkg in coretime mako archlinux-tweak-tool-git mpv wget polkit-gnome pavucontrol pamixer pipewire pipewire-audio pipewire-jack pipewire-pulse lib32-pipewire lib32-libpipewire jack wireplumber brightnessctl bluez bluez-utils blueman network-manager-applet gvfs thunar-archive-plugin file-roller neofetch neovim ranger fnm noise-suppression-for-voice viewnior cava ripgrep ffmpegthumbnailer btop dunst wl-clipboard wf-recorder hyprpicker-git hyprpaper-git tumbler imagemagick ncspot pix; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg... " 
            paru -Sy --needed --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done

    # Installing ZSH and related plugins
    echo -e "$CNT - Installing zsh, plugins... " 
    for pkg in zsh oh-my-zsh-git zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete-git zsh-autoswitch-virtualenv-git zsh-doc zsh-history-substring-search; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg... " 
            paru -Sy --needed --noconfirm "$pkg"
        else
            echo -e "$CNT - $pkg is already installed" 
        fi
    done

    # Installing theme utilities, themes, icons, fonts
    echo -e "$CNT - Installing themes, theme utilities... " 
    for pkg in arcolinux-candy-beauty-git wtype colord qt5-wayland qt6-wayland sweet-cursors-theme-git sweet-folders-icons-git sweet-gtk-theme-dark sweet-kvantum-theme-git kvantum nwg-look xfce4-settings ttf-cascadia-code-nerd ttf-cascadia-code-git sddm-git arcolinux-sddm-sugar-candy-git lxappearance; do
        if ! pacman -Qs "$pkg" > /dev/null ; then
            echo -e "$CNT - Installing $pkg... " 
            paru -Sy --needed --noconfirm "$pkg"
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
    echo -e "$CNT - Downloading and Installing NerdFonts/CascadiaCode... "
    mkdir -p $HOME/Downloads/nerdfonts/
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/CascadiaCode.zip
    unzip 'CascadiaCode.zip' -d $HOME/Downloads/nerdfonts/ && rm CascadiaCode.zip
    sudo cp -r $HOME/Downloads/nerdfonts/ /usr/share/fonts/ && sudo rm -r $HOME/Downloads/nerdfonts/
    paru -S --needed --noconfirm adobe-source-sans-fonts nerd-fonts-source-code-pro ttf-fira-mono ttf-font-awesome ttf-meslo-nerd-font-powerlevel10k ttf-ms-fonts ttf-nerd-fonts-symbols-mono ttf-roboto-mono ttf-jetbrains-mono ttf-iosevka-nerd ttf-fira-sans ttf-nerd-fonts-symbols
    echo -e "$CNT - Resetting Font Cache... "
    fc-cache -rv
    sleep 5
fi

# Define the folders and files to copy
folders_to_copy=(".cache" ".config" ".zsh" "Backgrounds" ".scripts")
files_to_copy=(".zshenv" ".p10k.zsh")

# Prompt the user to copy the folders and files
read -rp "Do you want to copy the folders and files? [y/N]: " copy_files
if [[ $copy_files == "Y" || $copy_files == "y" ]]; then
    for folder in "${folders_to_copy[@]}"; do
        echo -e "$CNT - Copying folder $folder... " 
        sudo cp -r "$folder" ~/ 
    done

    for file in "${files_to_copy[@]}"; do
        echo -e "$CNT - Copying file $file... " 
        sudo cp "$file" ~/ 
    done

    echo -e "$CNT - Config files have been moved." 
fi

# Set Scripts Executable
echo -e "$CNT - Setting scripts to executable... " 
sudo chmod +x ~/.scripts/colorpicker 
sudo chmod +x ~/.scripts/IOMMU.sh 
sudo chmod +x ~/.scripts/screensht
sudo chmod +x ~/.scripts/xhost.sh
sudo chmod +x ~/.scripts/notifications
sudo chmod +x ~/.scripts/startup
sudo chmod +x ~/.scripts/wofi-beats
sudo chmod +x ~/.scripts/xauthority
sudo chmod +x ~/.scripts/statusbar
sudo chmod +x ~/.scripts/keyhint
sudo chmod +x ~/.scripts/gtkthemes
sudo chmod +x ~/.scripts/waybar_update
sudo chmod +x ~/.scripts/waybar_ranger
sudo chmod +x ~/.scripts/waybar_btop

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

# Setup some theme settings
echo -e "$CNT - Setting up SDDM Background... "
sudo cp -r sddm_theme/ /usr/share/sddm/themes
sudo rm /usr/share/sddm/themes/sddm_theme/wallpaper.jpg
sudo cp ./sddm_theme/Backgrounds/1195480.jpg /usr/share/sddm/themes/sddm_theme/wallpaper.jpg
sudo cp ./etc/sddm.conf.d/autologin.conf /etc/sddm.conf.d/autologin.conf
sudo cp /etc/sddm.conf.d/autologin.conf /etc/sddm.conf.d/kde_settings.conf

# Enable Services
echo -e "$CNT - Starting Bluetooth Services... " 
sudo systemctl enable --now bluetooth.service 
sleep 2
echo -e "$COK - Bluetooth started successfully." 
echo -e "$CNT - Starting SDDM Services... " 
sudo systemctl enable sddm 
sleep 2
echo -e "$COK - SDDM started successfully." 
echo -e "$CNT - Removing conflicting XDG Portals... "
paru -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-desktop-portal-kde 

# Reset Font Cache
echo -e "$CNT - Rebuilding font cache... " 
fc-cache -f -v 
echo -e "$COK - Font cache rebuilt." 

# Script Complete
echo -e "$COK - Script Completed!" 
read -rp "Ready to get Hypr?[y/N]: " Hypr
if [[ $Hypr == "Y" || $Hypr == "y" ]]; then
    echo -e "$COK - System is going down for a reboot... Get Hypr!"
    sleep 5
    sudo shutdown -r 0
else
  exit
fi