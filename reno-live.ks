## Kickstart file for building a LiveCD capable of
## installing MicroRenovator offline

## Run this prior to livecd-creator
## Fixes the grub default so that the image auto-starts correctly
# sed -i 's/set default="1"/set default="0"/' /usr/lib/python3.6/site-packages/imgcreate/live.py

## Based on Fedora's Live-Workstation kickstart file,
## using the "livecd-tools" and "spin-kickstarts" packages
%include /usr/share/spin-kickstarts/fedora-live-workstation.ks

## add packages needed for Micro Renovator and EDK2
## remove a few uneeded & unwanted packages to save space
%packages
qemu-guest-agent
iucode-tool
microcode_ctl
emacs-nox
python2
uuid-devel
uuid-c++-devel
libuuid
libuuid-devel
nasm 
@Development Tools
gcc
gcc-c++
acpica-tools

-@dial-up
-libreoffice
-printing
-anaconda
-memtest86+
-@virtualization
%end


## Post installation tasks to customize live image startup
%post
echo "nameserver 8.8.8.8" > /etc/resolv.conf

git clone https://github.com/syncsrc/MicroRenovator.git
git clone https://github.com/tianocore/edk2.git
mv edk2/* MicroRenovator/edk2/

## Liveuser scripts autorun fedora-welcome on startup
## Replace it with a terminal to run MicroRenovator
touch /usr/share/applications/liveinst.desktop
mkdir -p /usr/share/anaconda/gnome/

cat << EOF > /usr/share/anaconda/gnome/ureno.sh
#!/bin/bash
cd /MicroRenovator/
sudo -s
EOF
chmod +x /usr/share/anaconda/gnome/ureno.sh

cat << EOF > /usr/share/anaconda/gnome/fedora-welcome.desktop
[Desktop Entry]
Name=uRenovate
Comment=Microcode Firmware updater
Keywords=renovate;reno;microcode;
Exec=/usr/share/anaconda/gnome/ureno.sh
Icon=utilities-terminal
Type=Application
StartupNotify=true
Categories=Utility;
Terminal=true
EOF
%end