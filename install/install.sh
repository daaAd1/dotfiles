#!/bin/bash
# Install file

# ****************** dependencies *********************
sudo dnf install -y clang make autoconf xcb-proto jsoncpp libmpdclient libxkbcommon exo i3-ipc network-manager-applet
sudo dnf install -y automake pkg-config flex bison cmake gperf gtk-doc intltool vala xfce4-dev-tools
sudo dnf install -y @development-tools help2man
sudo yum install -y compat-libstdc++-296.i686 compat-libstdc++-33.i686 ncurses-libs.i686 compat-libstdc++-33.x86_64
sudo yum install -y zlib.i686 ncurses-libs.i686 bzip2-libs.i6861

# ****************** library dependencies *********************
sudo dnf install -y xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel vala-devel 
sudo dnf install -y gettext-devel xcb-util-image-devel clang-devel m4ri-devel libxkbcommon-x11-devel
sudo dnf install -y glib2-devel gnutls-devel pcre2-devel  vte-devel vte3-devel libev-devel 
sudo dnf install -y libX11-devel libXext-devel libXScrnSaver-devel libxkbfile-devel
sudo yum install -y pam-devel alsa-lib-devel wireles-tools-devel libmpdclient-devel libcurl-devel

# ****************** google chrome *********************
su -c "
cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
exit"
sudo dnf install -y google-chrome-stable

# ****************** franz - messaging *********************
wget -P ~/Downloads https://github.com/meetfranz/franz/releases/download/v5.0.0-beta.14/franz-5.0.0-beta.14-x86_64.AppImage
chmod +x ~/Downloads/franz-5.0.0-beta.14-x86_64.AppImage
sudo mv ~/Downloads/franz-5.0.0-beta.14-x86_64.AppImage /opt
sudo cp ~/dotfiles/launchers/franz.sh /bin
sudo chmod +x /bin/franz.sh

# ****************** light *********************
cd ~/Downloads
git clone https://github.com/haikarainen/light
cd light
make
sudo make install
cd ..
rm -rf light

# ****************** i3 stuff *********************
sudo dnf install -y i3	
sudo dnf install -y i3lock
sudo dnf install -y feh
sudo dnf install -y xbacklight
sudo dnf install -y stow
sudo dnf install -y ImageMagick
sudo pip install Pillow	
 
# ****************** rofi, compton *********************
sudo dnf copr enable -y yaroslav/i3desktop
sudo dnf install -y compton rofi

# ****************** polybar *********************
cd ~/Downloads
git clone --recursive https://github.com/jaagr/polybar.git
mkdir polybar/build
cd polybar/build
cmake -DCMAKE_C_COMPILER="clang" -DCMAKE_CXX_COMPILER="clang++" -DENABLE_I3=ON ..
sudo make install
cd ..
cd ..
rm -rf polybar

# ****************** termite *********************
cd ~/Downloads
git clone https://github.com/thestinger/vte-ng
cd vte-ng
./autogen-sh
make
sudo make install
cd ..
git clone --recursive https://github.com/thestinger/termite.git
cd termite
make
sudo make install
rm -rf vte-ng
rm -rf termite

# ****************** zsh *********************
sudo dnf install -y zsh
#sudo dnf install -y zsh-syntax-highlighting
sudo mkdir /usr/share/zsh/plugins
cd /usr/share/zsh/plugins
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting

# ****************** thunar ********************* 
sudo dnf install -y thunar

# ****************** gnome-tweak-tool *********************
sudo dnf install -y gnome-tweak-tool

# ****************** icons *********************
# paper
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:snwh:paper/Fedora_25/home:snwh:paper.repo
sudo dnf install -y paper-icon-theme

# ****************** gtk-themes *********************
# arc-theme
sudo dnf install -y arc-theme
# lxappearance for setting it up
sudo dnf install -y lxappearance

# google-play-music-desktop-player
#sudo dnf install google-play-music-desktop-player-4.4.1.x86_64.rpm

# ****************** texlive + sablona tuke stuff*********************
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzvf install-tl-unx.tar.gz
# Have to do this manually
#cd install-tl-20171129/
#sudo ./install-tl -i
sudo dnf install -y texlive-cslatex texlive-hyphen-slovak latexmk texstudio texlive-engrec 

# ****************** sublime text *********************
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install -y sublime-text

# ****************** android studio stuff *********************
# virtualization
sudo dnf install -y @virtualization
sudo systemctl enable libvirtd
# android studio 
cd ~/Downloads
wget https://dl.google.com/dl/android/studio/ide-zips/3.0.1.0/android-studio-ide-171.4443003-linux.zip
unzip android-studio-ide-171.4443003-linux.zip
sudo mv android-studio-ide-171.4443003-linux/usr/local
sudo sh /usr/local/android-studio-ide-171.4443003-linux
sudo cp ~/dotfiles/launchers/android.sh /bin
sudo chmod +x /bin/android.sh

# ****************** stow config + fonts *********************
cd ~/dotfiles
stow i3
stow polybar
stow termite
stow xresources
xrdb ~/.Xresources
stow zsh
stow fonts
stow scripts
stow wallpaper

# ****************** lid close -> suspend + lock *********************
sudo cp ~/dotfiles/scripts/scripts/pylock.py /usr/bin/
sudo cp ~/dotfiles/install/i3lock.service /etc/systemd/system
sudo systemctl enable i3lock.service 





