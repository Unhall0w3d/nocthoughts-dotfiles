# nocthoughts-dotfiles
Dotfiles for the NOCThoughts Admin.

Intended for use on the following system:
Arch Linux - Minimal Profile - Pipewire

## NOTE ##

```
Sometimes 'greetd' doesn't play nice and tries to login with "//.scripts/start_hyprland". It seems to do this regardless of whether "$HOME/.scripts/start_hyprland"
or "~/.scripts/start_hyprland" is used in the config file for 'greetd'. You'll need to hit "F2" and edit the statement from "//.scripts/start_hyprland" to "~/.scripts/start_hyprland" and then login. I am working on fixing this, and it may be fixed by the time you read this. Just pay attention when logging in through greetd and if the login fails edit the login statement as described.
```

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

## Recommendations & TODO's after Installation.

```text
! This should now be handled through the script, leaving the instructions just in case ;)
1. SUPER+ENTER to launch Wezterm. You'll need to change your shell to zsh.
    a. sudo chsh <username> -s $(which zsh)
    b. Restart for the shell change to take effect, or source the .zshrc file.a
    c. Re-open Wezterm, with zsh as the prompt, and it should run through some plugin setup.
!

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

6. Update Sound Controls in Eww.
    a. pamixer --list-sources
        1. look for the input you want to control, e.g. "alsa_input.usb-Astro_Gaming_Astro_MixAmp_Pro-00.mono-fallback" and copy that name.
        2. Open up "~/.config/eww/eww.yuck"
        3. Line 12, edit the line from "(defpoll mic_percent :interval "3s" "pamixer --get-volume --source alsa_input.usb-Astro_Gaming_Astro_MixAmp_Pro-00.mono-fallback")" to "(defpoll mic_percent :interval "3s" "pamixer --get-volume --source your-microphone-source-name-here")".
        4. Similarly update line 123 to use your source name as used above.
    b. pamixer --list-sinks
        1. look for the output you want to control, e.g. "alsa_output.pci-0000_0d_00.4.analog-surround-21" and copy that name.
        2. Open up "~/.config/eww/eww.yuck"
        4. Line 11, edit the line from "(defpoll volume_percent :interval "1s"  "pamixer --get-volume --sink alsa_output.pci-0000_0d_00.4.analog-surround-21")" to "(defpoll volume_percent :interval "1s"  "pamixer --get-volume --sink your-output-sink-name-here")"
        5. Similarly update lines 96 and 234 to use your sink name as shown above.
    c. As a note, you could similarly use the sink number which appears before the sink or source name from "pamixer --list-sources|--list-sinks", however, if those identifiers change on reboot or for some god forsaken reason, you'll need to update the ID. The name really shouldn't change and is why I recommend using the sink/source name.
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
Me - For the patience to not give up regardless of how many times, and in what ways I broke things. :)
As well as the authors/maintainers of the packages installed via the script, Arch itself, sources for the wallpaper images, etc. You know who you are, you're beautiful, and I appreciate you.


## Cheatsheet (SUPER + F1)
```
#  o  o          o              o 
#  | /           |    o         | 
#  OO   o-o o  o O-o    o-o   o-O 
#  | \  |-' |  | |  | | |  | |  | 
#  o  o o-o o--O o-o  | o  o  o-o 
#              |                  
#           o--o                 
# Keybindings
# Cheatsheet
bind = SUPER, F1, exec, ~/.config/hypr/keybind
                      
# Application Bindings
bind = SUPER, B, exec, brave-bin
bind = CTRL ALT, L, exec, gtklock
bind = SUPER, X, exec, steam
bind = SUPER, E, exec, thunar

# Terminal
bind = SUPER, RETURN, exec, wezterm

# Launchers
bind = SUPER, D, exec, killall rofi || rofi -no-lazy-grab -show drun -theme "$HOME/.config/rofi/config.rasi" -terminal wezterm

# Hyprland Bindings
bind = SUPER, Q, killactive
bind = SUPER, J, togglesplit
bind = SUPER, T, togglefloating
bind = SUPER, H, fakefullscreen
bind = SUPER SHIFT, T, fullscreen

# Multimedia
binde=, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
binde=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
binde=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bind=, XF86AudioPlay, exec, playerctl play-pause
bind=, XF86AudioPause, exec, playerctl play-pause
bind=, XF86AudioNext, exec, playerctl next
bind=, XF86AudioPrev, exec, playerctl previous

# Screenshot
$screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"
bind = SUPER SHIFT, S, exec, $screenshotarea
bind = SUPER SHIFT, \, exec, grimblast --notify --cursor copysave output
bind = SUPER, S, exec, grimblast --notify --cursor copysave screen

# Misc
bind = SUPER SHIFT, X, exec, hyprpicker -a -n
bind = SUPER, escape, exec, wlogout --protocol layer-shell -b 5 -T 400 -B 400

# Window Manager
bind = SUPER, Q, killactive,
bind = SUPER SHIFT, Q, exit,
bind = SUPER, F, fullscreen,
bind = SUPER, Space, togglefloating,
bind = SUPER, P, pseudo, # dwindle
bind = SUPER, S, togglesplit, # dwindle

# Switch workspaces with mainMod
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
bind = SUPER, 5, workspace, 5
bind = SUPER, 6, workspace, 6
bind = SUPER, 7, workspace, 7
bind = SUPER, 8, workspace, 8
bind = SUPER, 9, workspace, 9
bind = SUPER, 0, workspace, 10
bind = SUPER ALT, up, workspace, e+1
bind = SUPER ALT, down, workspace, e-1

# Move Window to Workspace
bind = SUPER SHIFT, left, movewindow, l
bind = SUPER SHIFT, right, movewindow, r
bind = SUPER SHIFT, up, movewindow, u
bind = SUPER SHIFT, down, movewindow, d

# Move Mouse Focus
bind = SUPER, left, movefocus, l
bind = SUPER, right, movefocus, r
bind = SUPER, up, movefocus, u
bind = SUPER, down, movefocus, d

# Move To Workspace
bind = SUPER SHIFT, 1, movetoworkspace, 1
bind = SUPER SHIFT, 2, movetoworkspace, 2
bind = SUPER SHIFT, 3, movetoworkspace, 3
bind = SUPER SHIFT, 4, movetoworkspace, 4
bind = SUPER SHIFT, 5, movetoworkspace, 5
bind = SUPER SHIFT, 6, movetoworkspace, 6
bind = SUPER SHIFT, 7, movetoworkspace, 7
bind = SUPER SHIFT, 8, movetoworkspace, 8
bind = SUPER SHIFT, 9, movetoworkspace, 9
bind = SUPER SHIFT, 0, movetoworkspace, 10

# Resize Windows with Buttons
binde = SUPER CTRL, k, resizeactive,  0 -20
binde = SUPER CTRL, j, resizeactive,  0 20
binde = SUPER CTRL, l, resizeactive,  20 0
binde = SUPER CTRL, h, resizeactive, -20 0
binde = SUPER ALT,  k, moveactive,   0 -20
binde = SUPER ALT,  j, moveactive,    0 20
binde = SUPER ALT,  l, moveactive,    20 0
binde = SUPER ALT,  h, moveactive,   -20 0
bind = SUPER CTRL, left, resizeactive, -20 0
bind = SUPER CTRL, right, resizeactive, 20 0
bind = SUPER CTRL, up, resizeactive, 0 -20
bind = SUPER CTRL, down, resizeactive, 0 20

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = SUPER, mouse:272, movewindow
bindm = SUPER, mouse:273, resizewindow
bind = SUPER, mouse_down, workspace, e+1
bind = SUPER, mouse_up, workspace, e-1


# Tabbed
bind= SUPER, g, togglegroup
bind= SUPER, tab, changegroupactive

# Special
bind = SUPER, grave, togglespecialworkspace
bind = SUPERSHIFT, grave, movetoworkspace, special
```
