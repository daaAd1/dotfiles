#!/bin/bash

echo -e '\n/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~ Update, upgrade ~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/\n'

sudo apt -y update
sudo apt -y upgrade

echo -e '\n/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~ Installing packages ~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/\n'

sudo snap install spotify
sudo snap install --classic vscode
sudo apt install -y thunar
sudo apt install -y gnome-tweak-tool
sudo apt install -y gnome-system-monitor
sudo apt install -y zsh
sudo apt install -y vlc
sudo apt install -y zsh-syntax-highlighting
sudo apt install -y qbittorrent
sudo apt install -y stow
sudo apt-get install -y build-essential
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y npm
cd ~/dotfiles
stow termite
stow xresources
xrdb ~/.Xresources
stow zsh
stow fonts
stow wallpaper

sudo add-apt-repository -u ppa:snwh/ppa
sudo apt-get install -y paper-icon-theme
sudo apt-get install -y arc-theme


echo -e '\n/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~ Installing termite ~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/\n'
sudo apt-get install -y \
	git \
	g++ \
	libgtk-3-dev \
	gtk-doc-tools \
	gnutls-bin \
	valac \
	intltool \
	libpcre2-dev \
	libglib3.0-cil-dev \
	libgnutls28-dev \
	libgirepository1.0-dev \
	libxml2-utils \
	gperf

cd ~/Downloads
git clone --recursive https://github.com/thestinger/termite.git
git clone https://github.com/thestinger/vte-ng.git

echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
cd vte-ng && ./autogen.sh && make && sudo make install
cd ../termite && make && sudo make install
sudo ldconfig
sudo mkdir -p /lib/terminfo/x; sudo ln -s \
/usr/local/share/terminfo/x/xterm-termite \
/lib/terminfo/x/xterm-termite

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite 60

echo -e '\n/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~ Configure zsh ~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/\n'

sudo apt-get update
sudo apt-get install gawk curl

echo -e '\n/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~ Configuring gsettings ~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/\n'

gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-format 24h
gsettings set org.gnome.desktop.interface icon-theme 'Paper'
gsettings set org.gnome.desktop.interface cursor-theme 'dmz-black'
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.background secondary-color '#000000'
gsettings set org.gnome.desktop.background picture-uri 'file:////home/sepe/Downloads/dotfiles/wallpaper.png'
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'sk+qwerty')]"
gsettings set org.gnome.settings-daemon.peripherals.mouse locate-pointer true
gsettings set org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 5500
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
#gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false

echo -e '\n/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~ Installing Gnome extensions ~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/\n'

sudo wget -O /usr/local/bin/gnomeshell-extension-manage "https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage"
sudo chmod +x /usr/local/bin/gnomeshell-extension-manage
gnomeshell-extension-manage --install --extension-id 307 --version 3.28 --user # Dash to dock
gnomeshell-extension-manage --install --extension-id 104 --version 3.28 --user # NetSpeed
gnomeshell-extension-manage --install --extension-id 545 --version 3.28 --user # Hide top bar
gnomeshell-extension-manage --install --extension-id 1128 --version 3.22 --user #Hide Activities Button
gnomeshell-extension-manage --install --extension-id 15 --version 3.28 --user #AlternateTab
gnomeshell-extension-manage --install --extension-id 112 --version 3.18 --user #Remove Accessibility

echo -e '\n/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~~~~~ GRUB settings ~~~~~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/\n'

# Change grub background
sudo bash -c 'cat << EOF > /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.grub
if background_color 0,0,0; then
  clear
fi
EOF'
sudo update-grub

echo -e '\n/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~~~~ Removing packages ~~~~~~~~~~~~~~~~~~~~~~~/'
echo -e '/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/\n'

sudo snap remove -y gnome-calculator gnome-characters gnome-logs
sudo apt -y purge apport memtest86+
sudo apt -y autoremove
sudo apt -y clean
