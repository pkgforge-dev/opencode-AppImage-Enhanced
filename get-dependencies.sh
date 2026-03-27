#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm patchelf libnss_nis nss-mdns nss

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini

# Comment this out if you need an AUR package
# make-aur-package

echo "Getting binary..."
echo "---------------------------------------------------------------"
case "$ARCH" in
	x86_64)  farch=amd64;;
	aarch64) farch=arm64;;
esac
link=https://github.com/anomalyco/opencode/releases/latest/download/opencode-electron-linux-$farch.deb
if ! wget --retry-connrefused --tries=30 "$link" -O /tmp/temp.deb 2>/tmp/download.log; then
	cat /tmp/download.log
	exit 1
fi
ar xvf /tmp/temp.deb
tar -xvf ./data.tar.xz
rm -f ./*.xz /tmp/temp.deb

mkdir -p ./AppDir/bin
cp -rv ./opt/OpenCode/* ./AppDir/bin
cp -v ./usr/share/applications/@*.desktop ./AppDir
cp -v ./usr/share/icons/hicolor/150x150/apps/@*.png ./AppDir
