#just installs and configures dotfiles properly

#cd into the location of the script file
cd "$(dirname "$0")"

echo "write .xinitrc"
cat dotfiles/ConnorsSystemRC/ConnorsXinitrc/.xinitrc > ~/.xinitrc

echo ""
echo "write .bash_profile"
cat dotfiles/ConnorsSystemRC/ConnorsBash_profile/.bash_profile > ~/.bash_profile

echo ""
echo "write .bashrc"
cat dotfiles/ConnorsSystemRC/ConnorsBashrc/.bashrc > ~/.bashrc

echo ""
echo "append xresources"
cat dotfiles/ConnorsXresources/.Xresources >> ~/.Xresources

echo ""
echo "append tmux config"
#run as root
sudo bash -c "cat dotfiles/ConnorsTmuxConf/tmux.conf >> /etc/tmux.conf" 

echo ""
echo "load tmux config"
tmux source-file /etc/tmux.conf

echo ""
echo "append vimrc"
cat dotfiles/ConnorsVimrc/.vimrc >> ~/.vimrc

echo ""
echo "install icon theme"
cp -r dotfiles/ConnorsSystemBluetheme/iconThemes/Vimix-Beryl ~/.local/share/icons/.

echo ""
echo "write kde globals(for dolphin)"
cat dotfiles/ConnorsSystemBluetheme/kdeGlobals/kdeglobals > ~/.config/kdeglobals

echo ""
echo "write rofi config files"
cp -r dotfiles/ConnorsRofiConf/rofi/ ~/.config/.

echo ""
echo "download and install hack nerd font"
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
sudo unzip Hack.zip -d /usr/share/fonts/TTF/
rm Hack.zip

echo ""
echo "write picom config"
cp -r dotfiles/ConnorsPicomConf/picom ~/.config/.

echo ""
echo "write wallpapers"
mkdir ~/Pictures
cp -r dotfiles/ConnorsWallpapers/Wallpapers ~/Pictures/.

echo ""
echo "install dolphin, urxvt, rofi, btop, pamixer, picom, lxsession"
sudo pacman -Syy
sudo pacman -S dolphin rxvt-unicode rofi btop pamixer lxsession

#final message:
echo ""
echo "REMAINING STEPS: "
echo "1) Firefox theme can be found in dotfiles/ConnorsFirefox, this installs as an addon"
echo "2) Set GTK2 and GTK3 theme appropriately, a tool like lxappearance is a good tool that can do both."
echo "3) Set the QT5 Colorscheme using a tool such as qt5ct."
echo "4) Set konsole theme appropriately, as this will allows konsole's built in terminal to match urxvt"
echo "5) Set btop to use nordic theme as well as vim keys"
