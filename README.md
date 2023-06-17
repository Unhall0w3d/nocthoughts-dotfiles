# nocthoughts-dotfiles
Dotfiles for the NOCThoughts Admin.

Intended for use on the following system:
Arch Linux - Minimal Profile - Pipewire

## NOTE ##

Sometimes 'greetd' doesn't play nice and tries to login with "//.scripts/start_hyprland". It seems to do this regardless of whether "$HOME/.scripts/start_hyprland"
or "~/.scripts/start_hyprland" is used in the config file for 'greetd'. You'll need to hit "F2" and edit the statement from "//.scripts/start_hyprland" to "~/.scripts/start_hyprland" and then login. I am working on fixing this, and it may be fixed by the time you read this. Just pay attention when logging in through greetd and if the login fails edit the login statement as described.

## Screenshots

![alt text](https://raw.githubusercontent.com/Unhall0w3d/nocthoughts-dotfiles/main/screenshots/2023-06-17T15%3A31%3A22%2C850625312-04%3A00.png)

![alt text](https://raw.githubusercontent.com/Unhall0w3d/nocthoughts-dotfiles/main/screenshots/2023-06-17T15%3A36%3A26%2C906794696-04%3A00.png)

![alt text](https://raw.githubusercontent.com/Unhall0w3d/nocthoughts-dotfiles/main/screenshots/2023-06-17T15%3A37%3A55%2C391620600-04%3A00.png)

## Install requirements
Handled through the script:

```
paru
git
```

## Dependencies

- [hyprland](https://github.com/vaxerski/hyprland) - Wayland Compositor/WM
- [eww-wayland](https://github.com/elkowar/eww) - Bar and Widgets
- [CaskaydiaCode](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode) - Font for bar text and icons
- [fuzzel](https://codeberg.org/dnkl/fuzzel) - Rofi-like launcher
- [rofi](https://github.com/davatorium/rofi) - For search utility, since no Wayland utilities can handle custom Rofi modi (that I know of)
- [dunst](https://github.com/dunst-project/dunst) - Notification Daemon
- [mpvpaper](https://github.com/GhostNaN/mpvpaper) - Video Backgrounds
- [socat](http://www.dest-unreach.org/socat/) - Socket utility for eww workspace module
- [geticons](https://git.sr.ht/~zethra/geticons) - Show icon of focused application in eww.
- [macchina](https://github.com/Macchina-CLI/macchina) - (Optional) Fetch Script
- [trayer](https://github.com/sargon/trayer-srg) - Systray Utility (Optional)
- [wezterm](https://wezfurlong.org/wezterm/) - Terminal
- [ncspot](https://github.com/hrkfdn/ncspot) - Music (Spotify)
- [zsh](https://www.zsh.org/) - Shell
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) - Shell
- [discord-screenaudio](https://github.com/maltejur/discord-screenaudio)  - Discord
- [brave](https://brave.com/) - Browser

## Recommendations

```text
! This should now be handled through the script, leaving the instructions just in case ;)
1. SUPER+ENTER to launch Wezterm. You'll need to change your shell to zsh.
    a. sudo chsh <username> -s $(which zsh)
    b. Restart for the shell change to take effect, or source the .zshrc file.a
    c. Re-open Wezterm, with zsh as the prompt, and it should run through some plugin setup.

2. nvim/NvChad setup
    a. Set up nvchad/nvim by typing 'nvim' and walk through the setup.

4. Install "ruby" >= 2.60
    a. gem install colorls
    b. edit ~/.zshrc to add "source $(dirname $(gem which colorls))/tab_complete.sh" if desired.

5. Change Wallpapers
    a. Wallpapers should change on boot, or any time you restart hyprland (super+shift+q).
    b. Wallpapers can be manually changed through the following command:
        cd ~/.scripts
        ./wallpaper ~/Wallpapers
    c. You can add more wallpapers, or remove ones you don't like by adding or removing files from the ~/Wallpapers directory.

5. Edit How Many Eww Bars Open
    a. nano ~/.config/eww/launch_bar
    b. Edit line 4 to remove "bar1" and/or "bar2" if you're only using one monitor. If you're using two, remove "bar2". If you're using 3, leave it alone.
```

## Installation

The script starts out by fulfilling dependency requirements (git|paru).
Once confirmed installed (either because it is already or because the script installs it) the script progresses to proper setup and installation.
The script may require the 'sudo' password at certain times. This should not be left alone as it is possible the script will stall waiting for you.

```zsh
cd ~/Downloads/
git clone https://github.com/Unhall0w3d/nocthoughts-dotfiles.git
cd nocthoughts-dotfiles
./setup.sh
```

## Credits

Credits will change as the dotfiles and theming change and are hand customized away from presets cobbled together from others. Regardless, I wouldn't have this setup without the efforts and available materials of others. Thank you.

[LinuxMobile](https://github.com/linuxmobile)
[SolDoesTech](https://github.com/SolDoesTech)
[Taylor85345](https://github.com/taylor85345)
[yeyushengfan258](https://github.com/yeyushengfan258/Inverse-dark-kde)
[manjaro](https://github.com/manjaro/artwork-breath-gtk)
As well as the authors/maintainers of the packages installed via the script, Arch itself, etc. You know who you are.
