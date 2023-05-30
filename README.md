# nocthoughts-dotfiles
Dotfiles for the NOCThoughts Admin. Arch _ Hyprland

# Requirements

**Arch Linux**
```
This script has only been tested on a base install of Arch Linux, and was built for Arch Linux.
Usage on any other distro is considered unsupported.
```

**python**
```zsh
pacman -Syu python
```

**git**
```zsh
pacman -Syu git
```

**paru**
```zsh
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
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

```zsh
cd ~/Downloads/
git clone https://github.com/Unhall0w3d/nocthoughts-dotfiles.git
cd nocthoughts-dotfiles
python setup.py
```

# Screenshots

[My RIP (Rice-In-Progress)](https://imgur.com/a/mM3YFSA)