#!/usr/bin/env bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

release=$(lsb_release -c -s)

# Check if the script is running under Ubuntu 18.04 Bionic Beaver
if [ "$release" != "bionic" ] && [ "$release" != "disco" ] && [ "$release" != "eoan" ] ; then
    >&2 echo -e "${RED}This script is made for Ubuntu 18.04/19.04/19.10!${NC}"
    exit 1
fi

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
    >&2 echo -e "${RED}Please run xps-tweaks as root!${NC}"
    exit 2
fi

# Enable universe and proposed
add-apt-repository -y universe
sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list
apt -y update
apt -y full-upgrade
apt -y install synaptic apt-transport-https curl gdebi-core git

# Ask for installing Brave
echo -e "${GREEN}Now you are installing: Brave, R, LaTeX, Sublime, Mailspring, plank${NC}"

## for Brave
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
source /etc/os-release
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list

# for NordVPN
wget -qnc https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb

# for Zotero
wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | bash

# for timeshift
add-apt-repository -y ppa:teejee2008/ppa

# for Sublime
apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"

# for rEFInd
add-apt-repository ppa:rodsmith/refind

# for inSync
if [ "$release" != "eoan" ] ; then
    >&2 echo -e "${RED}inSync is scripted only for eoan${NC}"
else
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
touch /etc/apt/sources.list.d/insync.list
echo "deb http://apt.insync.io/ubuntu eoan non-free contrib" >> /etc/apt/sources.list.d/insync.list
fi

## Update and install all
apt update
apt -y install brave-browser plank libopenblas-base r-base r-base-dev calibre zotero sublime-text gnome-tweak-tool chrome-gnome-shell timeshift unrar zip unzip p7zip-full p7zip-rar rar wine winetricks telegram-desktop refind
# nordvpn yet not able to install by command line
snap install mailspring whatsdesk dropbox

# rEFInd things
rm -rf {regular-theme,refind-theme-regular}
git clone https://github.com/mtorressahli/refind-theme-regular.git
rm -rf refind-theme-regular/{src,.git}
rm refind-theme-regular/install.sh
rm -rf /boot/efi/EFI/refind/{regular-theme,refind-theme-regular}
cp -r refind-theme-regular /boot/efi/EFI/refind/
rm -rf {regular-theme,refind-theme-regular}
echo "include refind-theme-regular/theme.conf" >> /boot/efi/EFI/refind/refind.conf
grep -qxF 'include refind-theme-regular/theme.conf' /boot/efi/EFI/refind/refind.conf || echo "include refind-theme-regular/theme.conf" >> /boot/efi/EFI/refind/refind.conf

#R things
apt -y install default-jre default-jdk
R CMD javareconf
apt -y build-dep libcurl4-gnutls-dev
apt -y install openmpi-bin openmpi-common libssl-dev r-cran-xml wajig libxml2-dev libcurl4-openssl-dev # libcurl4-gnutls-dev
wajig install libgtk2.0-dev

# Ask for installing LaTeX
echo -e "${GREEN}Do you wish to install LaTeX (i.e. texlive-full) now? (tip: it takes a long time)${NC}"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) atp -y install texlive-full; break;;
        No ) break;;
    esac
done
