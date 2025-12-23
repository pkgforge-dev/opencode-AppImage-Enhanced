#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
# pacman -Syu --noconfirm PACKAGESHERE

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
if [ "$ARCH" = 'aarch64' ]; then
	PRE_BUILD_CMDS="sed -i -e 's|amd64|arm64|' ./PKGBUILD"
fi
make-aur-package opencode-desktop-bin

# If the application needs to be manually built that has to be done down here
