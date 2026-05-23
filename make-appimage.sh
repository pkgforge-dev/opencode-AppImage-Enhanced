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

# Add AdwaitaSnas font that OpenCode requests, as fallback can fail and show no text
wget --retry-connrefused --tries=30 https://gitlab.gnome.org/GNOME/adwaita-fonts/-/raw/main/sans/AdwaitaSans-Regular.ttf -O ./AppDir/share/fonts/AdwaitaSans-Regular.ttf

# Turn AppDir into AppImage
quick-sharun --make-appimage
