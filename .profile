#                o-o  o     
#                |  o |     
#  o-o  o-o o-o -O-   | o-o 
#  |  | |   | |  |  | | |-' 
#  O-o  o   o-o  o  | o o-o 
#  |                        
#  o   
# Start SSH Auth Sock
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# Export QT5CT required variable
QT_QPA_PLATFORMTHEME=qt5ct; export QT_QPA_PLATFORMTHEME
PIPEWIRE_RUNTIME_DIR=$XDG_RUNTIME_DIR; export PIPEWIRE_RUNTIME_DIR
