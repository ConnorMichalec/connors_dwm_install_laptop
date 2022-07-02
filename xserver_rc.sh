#Run dis on the start of the xserver(should be placed in .xinitrc if there is no login/display manager)

#set mouse sensitvity
xinput --set-prop 8 'libinput Accel Speed' -0.83

#load picom compositor w/ experiment backends
picom --experimental-backends &

#load desktop wallpaper
feh --bg-fill ~/Pictures/Wallpapers/Stars_space_2monitor_right_1.jpg --bg-fill ~/Pictures/Wallpapers/Stars_space_2monitor_left_1.jpg

#load Xresources
[[ -f ~/.Xresources ]] && xrdb ~/.Xresources

#authentication agent
lxpolkit & 

#start dwm bar
~/connors_dwm_install_laptop/statusbar.sh &

#start flameshot service
flameshot &

#start rot8 for screen rotatoin, you may have to edit the touchescreen input devices appropriately with xinput --list in order for the input devices to rotate
rot8 --touchscreen "Wacom HID 5308 Finger" "Wacom HID 5308 Pen Pen (0x81a19ebc)" &

#start dwm
exec dwm



