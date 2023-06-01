#  (   (       )    *    (      *            
#  )\ ))\ ) ( /(  (  `   )\ ) *  *   )  
# (()/(()/( )\()) )\))( (()/( )\))  /(  
#  /(_))(_)|(_)\ ((_)()\ /(_)|(_)()(_)) 
# (_))(_))   ((_)(_()((_|_)) (_()((_())  
# | _ \ _ \ / _ \|  \/  | _ \|_   _|  
# |  _/   /| (_) | |\/| |  _/  | |    
# |_| |_|_\ \___/|_|  |_|_|    |_|  

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

 End of lines added by compinstall
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ColorLS
if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls"
    alias la="colorls -al"
fi

# Color Exa
if [ -x "$(command -v exa)" ]; then
    alias ls="exa"
    alias la="exa --long --all --group"
fi

neofetch
