#Run dis on the start of the xserver(should be placed in .xinitrc if there is no login/display manager)

#set mouse sensitvity
xinput --set-prop 8 'libinput Accel Speed' -0.83

#load picom compositor w/ experiment backends
picom --experimental-backends &

#load desktop wallpaper
feh --bg-fill ~/Pictures/Wallpapers/Stars_space_2monitor_right_1.jpg --bg-fill ~/Pictures/Wallpapers/Stars_space_2monitor_left_1.jpg

#load Xresources
[[ -f ~/.Xresources ]] && xrdb ~/.Xresources

#start dwm bar
/home/connor/dwm_install/statusbar.sh &


#authentication agent
lxpolkit & 

#start dwm
exec dwm

