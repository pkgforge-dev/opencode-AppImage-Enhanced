#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q opencode-desktop-bin | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/128x128/apps/OpenCode.png
export DESKTOP=/usr/share/applications/OpenCode.desktop

# Deploy dependencies
quick-sharun \
	/usr/bin/OpenCode \
	/usr/bin/opencode-cli

# bun makes binaries that self extract and read /proc/self/exe
# they are also very delicate and get broken by strip
kek=.$(tr -dc 'A-Za-z0-9_=-' < /dev/urandom | head -c 10)
rm -f ./AppDir/bin/opencode-cli         ./AppDir/shared/bin/opencode-cli
cp -v /usr/bin/opencode-cli             ./AppDir/bin/opencode-cli.wrapped
patchelf --set-interpreter /tmp/"$kek"  ./AppDir/bin/opencode-cli.wrapped
patchelf --set-rpath '$ORIGIN/../lib'   ./AppDir/bin/opencode-cli.wrapped

cat <<EOF > ./AppDir/bin/opencode-cli
#!/bin/sh
cp -f "\$APPDIR"/shared/lib/ld-linux*.so* /tmp/"$kek"
exec "\$APPDIR"/bin/opencode-cli.wrapped "\$@"
EOF
chmod +x ./AppDir/bin/opencode-cli*

# Turn AppDir into AppImage
quick-sharun --make-appimage
