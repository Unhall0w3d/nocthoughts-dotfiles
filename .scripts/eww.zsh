#!/bin/zsh
# Start EWW Bar(s)
# Comment out bar1/bar2 to remove bars on Monitor 1, Monitor 2 (per hyprctl).
eww kill
sleep 2
eww daemon &
eww open bar0 &
eww open bar1 &
eww open bar2 &
