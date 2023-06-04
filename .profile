# Start SSH Auth Sock
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# Export QT5CT required variable
QT_QPA_PLATFORMTHEME=qt5ct; export QT_QPA_PLATFORMTHEME
