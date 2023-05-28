import subprocess
import os
import shutil


def main():
    # Run the command to install packages
    command = 'paru -Syu hyprland-git polkit-kde-agent dunst grimblast rofi rofi-emoji wl-clipboard wf-recorder ' \
              'wlogout grimblast-git hyprpicker-git hyprpaper-git xdg-desktop-portal-hyprland-git ffmpegthumbnailer ' \
              'tumbler wtype colord imagemagick swaylock-effects qt5-wayland qt6-wayland ripgrep waybar-hyprland-git ' \
              'catppuccin-gtk-theme-mocha catppuccin-cursors-mocha catppuccin-mocha-grub-theme-git nwg-look cava ' \
              'pavucontrol ranger zsh starship neovim viewnior noise-suppression-for-voice thunar ' \
              'thunar-archive-plugin file-roller zsh oh-my-zsh zsh-autosuggestions zsh-autocomplete-git ' \
              'zsh-autoswitch-virtualenv-git zsh-doc zsh-history-substring-search btop sddm-git'
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

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

    # Copy the .cache, .config, .zsh, .zshrc, .p10k.zsh, Backgrounds, and Scripts to $HOME directory
    folders_to_copy = ['.cache', '.config', '.zsh', 'Backgrounds', 'Scripts']
    files_to_copy = ['.zshrc', '.p10k.zsh']
    home_directory = os.path.expanduser('~')

    for folder in folders_to_copy:
        source_folder = folder
        destination_folder = os.path.join(home_directory, folder)

        if not os.path.exists(destination_folder):
            os.makedirs(destination_folder)

        shutil.copytree(source_folder, destination_folder, symlinks=True, copy_function=shutil.copy2)

        print(f'Copied {folder} folder to {destination_folder}')

    for file in files_to_copy:
        source_file = file
        destination_file = os.path.join(home_directory, file)

        shutil.copy2(source_file, destination_file)

        print(f'Copied {file} file to {destination_file}')

    print("Config files have been moved. Please restart.")


if __name__ == "__main__":
    main()
