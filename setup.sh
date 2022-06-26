#just installs and configures dotfiles properly

#exit script if any command fails
set -e 

#cd into the location of the script file
cd "$(dirname "$0")"

echo ""
echo "install dolphin, urxvt, rofi, btop, pulseaudio, pamixer, picom, lxsession, feh, qt5ct, lxappearance, konsole, unzip, tmux, vim, base-devel, xorg, xorg-xinit, libx11, libxinerama, libxft, webkit2gtk, ranger, w3m, flameshot, git"

sudo pacman -Syy
sudo pacman -S archlinux-keyring --noconfirm #to fix pgp correupted problems
sudo pacman -S dolphin rxvt-unicode rofi btop pulseaudio pamixer picom lxsession feh lxappearance qt5ct konsole unzip tmux vim base-devel xorg xorg-xinit libx11 libxinerama libxft webkit2gtk ranger w3m flameshot git --noconfirm

echo ""
echo "init dwm submodule"
git submodule update --init 

echo ""
echo "write .xinitrc"
cat dotfiles/ConnorsSystemRC/ConnorsXinitrc/.xinitrc > ~/.xinitrc

echo ""
echo "write .bash_profile"
cat dotfiles/ConnorsSystemRC/ConnorsBash_profile/.bash_profile > ~/.bash_profile

echo ""
echo "write .bashrc"
cat dotfiles/ConnorsSystemRC/ConnorsBashrc/.bashrc > ~/.bashrc

echo ""
echo "write xresources"
#cat dotfiles/ConnorsXresources/.Xresources >> ~/.Xresources
cat dotfiles/ConnorsXresources/.Xresources > ~/.Xresources #switch to write

echo ""
echo "write konsole colorscheme"
mkdir -p ~/.local/share/konsole
cp dotfiles/ConnorsKonsole_xresources_copied/ConnorsSystemBluetheme.colorscheme ~/.local/share/konsole/.

echo ""
echo "write ranger config"
mkdir -p ~/.config/ranger/
#cat dotfiles/ConnorsRangerConfig/rc.conf >> ~/.config/ranger/rc.conf
cat dotfiles/ConnorsRangerConfig/rc.conf >> ~/.config/ranger/rc.conf #switch to write

echo ""
echo "write tmux config"
#run as root
#sudo bash -c "cat dotfiles/ConnorsTmuxConf/tmux.conf >> /etc/tmux.conf" 
sudo bash -c "cat dotfiles/ConnorsTmuxConf/tmux.conf > /etc/tmux.conf" #switch to write

echo ""
echo "load tmux config"
tmux source-file /etc/tmux.conf

echo ""
echo "write vimrc"
#cat dotfiles/ConnorsVimrc/.vimrc >> ~/.vimrc
cat dotfiles/ConnorsVimrc/.vimrc > ~/.vimrc #switch to write

echo ""
echo "install icon theme"
git clone https://github.com/vinceliuice/vimix-icon-theme
vimix-icon-theme/install.sh -a
sudo rm -r vimix-icon-theme

echo ""
echo "write themix colors"
mkdir -p ~/.config/oomox/colors
cp dotfiles/ConnorsSystemBluetheme/themixcolors/ConnorsSystemBluetheme ~/.config/oomox/colors/.

echo ""
echo "write kde globals(for dolphin's broken theming)"
cat dotfiles/ConnorsSystemBluetheme/kdeGlobals/kdeglobals > ~/.config/kdeglobals

echo ""
echo "write rofi config files"
mkdir -p ~/.config
cp -r dotfiles/ConnorsRofiConf/rofi/ ~/.config/.

echo ""
echo "download and install hack nerd font"
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
sudo mkdir -p /usr/share/fonts/TTF/
sudo unzip Hack.zip -d /usr/share/fonts/TTF/
rm Hack.zip

echo ""
echo "write picom config"
cp -r dotfiles/ConnorsPicomConf/picom ~/.config/.

echo ""
echo "write wallpapers"
mkdir -p ~/Pictures
cp -r dotfiles/ConnorsWallpapers/Wallpapers ~/Pictures/.

echo ""
echo "append qt5ct required environment vars to /etc/environment"
sudo bash -c "echo QT_QPA_PLATFORMTHEME=qt5ct >> /etc/environment"

echo ""
echo "install yay"
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si --noconfirm
cd ..
sudo rm -r yay-git

echo ""
echo "install archey(through yay)"
yay -S archey --noconfirm

echo ""
echo "install qt5-styleplugins(through yay)" #this adds gtk2 converter option to qt5ct for ui elements
yay -S qt5-styleplugins --noconfirm

echo ""
echo "install themix(through yay)" #this is what i used for creating the theme and is needed to apply it properly
yay -S themix-full-git --noconfirm

echo ""
echo "install gotop(through yay)"
yay -S gotop --noconfirm

echo ""
echo "build and install dwm itself"
cd dwm
sudo make clean install
cd ..

#final message:
echo ""
echo "REMAINING STEPS: "
echo "1) Reboot to make sure services are going"
echo "2) Firefox theme can be found in dotfiles/ConnorsFirefox, this installs as an addon"
echo "3) Open themix-gui and export system theme"
echo "4) Set GTK2 and GTK3 theme and font to the theme just exported, a tool like lxappearance is a good tool that can do both."
echo "5) Set the QT5 Colorscheme and font to the scheme just exported using a tool such as qt5ct(first set the style to GTK2)."
echo "6) Set konsole theme appropriately, as this will allows konsole's built in terminal to match urxvt"
echo "7) Set btop to use nordic theme as well as vim keys"
