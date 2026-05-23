#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/anomalyco/opencode/refs/heads/dev/packages/desktop/icons/prod/128x128.png
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun \
	./AppDir/bin/*          \
	/usr/lib/libnss_nis.so* \
	/usr/lib/libnsl.so*     \
	/usr/lib/libnss_mdns*_minimal.so*

pacman -S --noconfirm adwaita-fonts

# Add AdwaitaSans font that OpenCode requests, as fallback can fail and show no text
mkdir -p ./AppDir/share/fonts/Adwaita
cp -v /usr/share/fonts/Adwaita/AdwaitaSans-Regular.ttf ./AppDir/share/fonts/Adwaita

# Turn AppDir into AppImage
quick-sharun --make-appimage
