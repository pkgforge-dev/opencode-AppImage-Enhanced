#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q opencode-desktop-bin | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DEPLOY_OPENGL=1

# save the bun binary for later
cp -v ./AppDir/bin/resources/opencode-cli ./

# Deploy dependencies
quick-sharun \
	./AppDir/bin/*          \
	/usr/lib/libnss_nis.so* \
	/usr/lib/libnsl.so*     \
	/usr/lib/libnss_mdns*_minimal.so*

# bun makes binaries that self extract and read /proc/self/exe
# they are also very delicate and get broken by strip
f=./AppDir/bin/opencode-cli
rm -f "$f" ./AppDir/bin/resources/opencode-cli
kek=.$(tr -dc 'A-Za-z0-9_=-' < /dev/urandom | head -c 10)
cp -v ./opencode-cli "$f"
patchelf --set-interpreter /tmp/"$kek" "$f"
patchelf --set-rpath '$ORIGIN/../lib' "$f"
ln -s ../opencode-cli  ./AppDir/bin/resources/opencode-cli

cat <<EOF > ./AppDir/bin/random-linker.src.hook
#!/bin/false
cp -f "\$APPDIR"/shared/lib/ld-linux*.so* /tmp/"$kek"
EOF

# Turn AppDir into AppImage
quick-sharun --make-appimage
