#just installs and configures dotfiles properly

#cd into the location of the script file
cd "$(dirname "$0")"

echo ""
echo "install dolphin, urxvt, rofi, btop, pulseaudio, pamixer, picom, lxsession, feh, qt5ct, lxappearance, konsole, unzip, tmux, vim, base-devel, xorg, xorg-xinit, libx11, libxinerama, libxft, webkit2gtk, git"
sudo pacman -Syy
sudo pacman -S archlinux-keyring --noconfirm #to fix pgp correupted problems
sudo pacman -S dolphin rxvt-unicode rofi btop pulseaudio pamixer picom lxsession feh lxappearance qt5ct konsole unzip tmux vim base-devel xorg xorg-xinit libx11 libxinerama libxft webkit2gtk git --noconfirm

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
echo "write konsole colorscheme"
mkdir -p ~/.local/share/konsole
cp dotfiles/ConnorsKonsole_xresources_copied/ConnorsSystemBluetheme.colorscheme ~/.local/share/konsole/.

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
mkdir -p ~/.local/share/icons
cp -r dotfiles/ConnorsSystemBluetheme/iconThemes/Vimix-Beryl ~/.local/share/icons/.

echo ""
echo "install system theme"
mkdir ~/.themes
cp -r dotfiles/ConnorsSystemBluetheme/themes/oomox-ConnorsSystemBluetheme ~/.themes

echo ""
echo "write kde globals(for dolphin)"
cat dotfiles/ConnorsSystemBluetheme/kdeGlobals/kdeglobals > ~/.config/kdeglobals

echo ""
echo "write rofi config files"
mkdir ~/.config
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
mkdir ~/Pictures
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
echo "build and install dwm itself"
cd dwm
sudo make clean install
cd ..

#final message:
echo ""
echo "REMAINING STEPS: "
echo "1) Reboot to make sure services are going"
echo "2) Firefox theme can be found in dotfiles/ConnorsFirefox, this installs as an addon"
echo "3) Set GTK2 and GTK3 theme and font, a tool like lxappearance is a good tool that can do both."
echo "4) Set the QT5 Colorscheme and font using a tool such as qt5ct."
echo "5) Set konsole theme appropriately, as this will allows konsole's built in terminal to match urxvt"
echo "6) Set btop to use nordic theme as well as vim keys"
