#     ) (       ) (          
#  ( /( )\ ) ( /( )\ )  (    
#  )\()|()/( )\()|()/(  )\   
# ((_)\ /(_)|(_)\ /(_)|((_)  
#  _((_|_))  _((_|_)) )\___  
# |_  // __|| || | _ ((/ __| 
#  / / \__ \| __ |   /| (__  
# /___||___/|_||_|_|_\ \___|

while read file
do 
  source "$ZDOTDIR/$file.zsh"
done <<-EOF
theme
env
aliases
utility
options
plugins
keybind
prompt
EOF

# vim:ft=zsh:nowrap
