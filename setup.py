import subprocess
import os
import shutil


class DotFileSetup:
    def __init__(self):
        self.pkglist = 'paru -Syu hyprland-git polkit-kde-agent dunst grimblast rofi rofi-emoji wl-clipboard ' \
                       'wf-recorder wlogout grimblast-git hyprpicker-git hyprpaper-git xdg-desktop-portal-hyprland-git ' \
                       'ffmpegthumbnailer tumbler wtype colord imagemagick swaylock-effects qt5-wayland qt6-wayland ' \
                       'ripgrep waybar-hyprland-git catppuccin-gtk-theme-mocha catppuccin-cursors-mocha ' \
                       'catppuccin-mocha-grub-theme-git nwg-look cava pavucontrol ranger zsh starship neovim viewnior ' \
                       'noise-suppression-for-voice thunar thunar-archive-plugin file-roller zsh oh-my-zsh ' \
                       'zsh-autosuggestions zsh-autocomplete-git zsh-autoswitch-virtualenv-git zsh-doc ' \
                       'zsh-history-substring-search btop sddm-git sddm-sugar-candy-git swappy network-manager-applet ' \
                       'gvfs nvchad-git'
        self.nvchad = 'git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1'
        self.folders_to_copy = ['.cache', '.config', '.zsh', 'Backgrounds', '.scripts']
        self.files_to_copy = ['.zshrc', '.p10k.zsh']
        self.home_directory = os.path.expanduser('~')

    def pkg_install(self):
        # Run the command to install packages
        process = subprocess.Popen(self.pkglist, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        while process.poll() is None:
            output = process.stdout.readline().decode('utf-8')
            if output:
                print(output.strip())
            error = process.stderr.readline().decode('utf-8')
            if error:
                print(error.strip())

        # Process has finished, print any remaining output
        for output in process.stdout.readlines():
            print(output.decode('utf-8').strip())

        for error in process.stderr.readlines():
            print(error.decode('utf-8').strip())

        # Get the process return code
        return_code = process.returncode
        print('Command executed with return code:', return_code)

    def nvchad_setup(self):
        # Run the command to install packages
        process = subprocess.Popen(self.nvchad, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        while process.poll() is None:
            output = process.stdout.readline().decode('utf-8')
            if output:
                print(output.strip())
            error = process.stderr.readline().decode('utf-8')
            if error:
                print(error.strip())

        # Process has finished, print any remaining output
        for output in process.stdout.readlines():
            print(output.decode('utf-8').strip())

        for error in process.stderr.readlines():
            print(error.decode('utf-8').strip())

        # Get the process return code
        return_code = process.returncode
        print('Command executed with return code:', return_code)

    def dotfile_install(self):
        # Copy the .cache, .config, .zsh, .zshrc, .p10k.zsh, Backgrounds, and Scripts to $HOME directory

        for folder in self.folders_to_copy:
            source_folder = folder
            destination_folder = os.path.join(self.home_directory, folder)

            if not os.path.exists(destination_folder):
                os.makedirs(destination_folder)

            shutil.copytree(source_folder, destination_folder, symlinks=True, copy_function=shutil.copy2)

            print(f'Copied {folder} folder to {destination_folder}')

        for file in self.files_to_copy:
            source_file = file
            destination_file = os.path.join(self.home_directory, file)

            shutil.copy2(source_file, destination_file)

            print(f'Copied {file} file to {destination_file}')

        print("Config files have been moved. Please restart.")

        if not os.path.exists("/usr/share/zsh-theme-powerlevel10k"):
            os.makedirs("/usr/share/zsh-theme-powerlevel10k")
        shutil.copy2("./usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme",
                     "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme")
        shutil.copy2("./usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme.zwc",
                     "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme.zwc")

    def main(self):
        print("Welcome to the NOCThought DotFile Installer... ")
        print("Review the list below and confirm you want to install the required packages... ")
        print(self.pkglist)
        print("This is your opportunity to back out. I will not provide an opportunity to exit. If necessary, ctrl+c.")
        print("I'm not responsible for any damage you do by using this script.")
        print("Despite what my wife says, I'm not the cause of all the world's problems. Some, not all.")
        while True:
            installpkg = input("Ready to install?(Y/n): ")
            if installpkg.lower() != 'y':
                print("I understand. You're either scared, or didn't input 'y'. Come back when you have the resolve.")
                exit()
            else:
                break
        print("Beginning package installation via paru...")
        self.pkg_install()
        print("Package installation complete...")
        while True:
            dotfilesetup = input("Ready to setup dotfiles and required scripts/background?(Y): ")
            if dotfilesetup.lower() == 'y':
                print("Moving files... ")
                self.dotfile_install()
                print("Dotfiles have been moved successfully... ")
                print("Setting up NvChad... ")
                self.nvchad_setup()
                print("NvChad is in place. Please run 'nvim' and run through the setup. Any issues should be "
                      "reported to NvChad.")
                break
        print("Installation of packages and placement of config files has been completed...")
        print("You may want to edit the ~/.config/hypr/hyprland.conf according to your monitor layout.")
        print("I would also recommend editing keybindings to your preference. Don't forget to run and set up nvim.")


if __name__ == "__main__":
    DotFileSetup.main()
    exit()
