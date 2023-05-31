# nocthoughts-dotfiles
Dotfiles for the NOCThoughts Admin. Arch _ Hyprland


# Requirements

**Arch Linux**
```
This script has only been tested on a base install of Arch Linux, and was built for Arch Linux.
If, for some reason, you want to run the Hyprland or Hypr iterations of 'ArcoLinuxB', this can be 'installed' over the top of it cleanly, and was tested on a Dell Latitude 5490 using Minimal Arch Install via 'archinstall', ArcoLinuxB Hyprland, and ArcoLinuxB Hypr.
Why you would want to slap this on Arco, I don't know. You'd probably introduce unnecessary bloat. It's your system, mess it up however you wish. :)
```
**git**
```
pacman -Sy git
```

# Recommendations

```text
1. I recommend updating the ~/.config/hypr/hyprland.conf monitor configs to match your layout.
    a. As-is the monitor layout is two stacked "landscape" 1920x1080@144 monitors, with a 1920x1080@60 "portrait" monitor to the left.
2. SUPER+ENTER to launch Wezterm. You'll need to change your shell to zsh.
    a. sudo chsh <username> -s $(which zsh)
    b. Restart for the shell change to take effect, or source the .zshrc file.a
    c. Re-open Wezterm, with zsh as the prompt, and it should run through some plugin setup.
3. nvim/NvChad setup
    a. Set up nvchad/nvim by typing 'nvim' and walk through the setup.
4. Review ~/.conf/hypr/hyprland.conf regarding "xhost +" script that is invoked.
    a. This was used to fix some programs (Gtk primarily). If it's too insecure for you, pursue an alternative solution.
    b. Comment out the line, or remove it and the corresponding script file it points to.
    c. Otherwise, leave it alone.
5. Install "ruby" >= 2.60
    a. gem install colorls
    b. edit ~/.zshrc to add "source $(dirname $(gem which colorls))/tab_complete.sh" if desired.
6. Re-install Paru
    a. Because you won't have the paru completions, you can solve it or you can do a dance of compiling yay, using yay to remove paru, reinstall paru using yay, then uninstall yay.
    b. Whatever works for you.
```

# Installation

The script starts out by fulfilling dependency requirements (git|paru).
Once confirmed installed (either because it is already or because the script installs it) the script progresses to proper setup and installation.

```zsh
cd ~/Downloads/
git clone https://github.com/Unhall0w3d/nocthoughts-dotfiles.git
cd nocthoughts-dotfiles
chmod +x setup.sh
./setup.sh
```

# Screenshots

[My RIP (Rice-In-Progress)](https://imgur.com/a/mM3YFSA)