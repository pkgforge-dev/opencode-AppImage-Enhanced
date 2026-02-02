<div align="center">

# opencode-AppImage-Enhanced 🐧

[![GitHub Downloads](https://img.shields.io/github/downloads/pkgforge-dev/opencode-AppImage-Enhanced/total?logo=github&label=GitHub%20Downloads)](https://github.com/pkgforge-dev/opencode-AppImage-Enhanced/releases/latest)
[![CI Build Status](https://github.com//pkgforge-dev/opencode-AppImage-Enhanced/actions/workflows/appimage.yml/badge.svg)](https://github.com/pkgforge-dev/opencode-AppImage-Enhanced/releases/latest)
[![Latest Stable Release](https://img.shields.io/github/v/release/pkgforge-dev/opencode-AppImage-Enhanced)](https://github.com/pkgforge-dev/opencode-AppImage-Enhanced/releases/latest)

<p align="center">
  <img src="https://github.com/anomalyco/opencode/blob/dev/packages/identity/mark-512x512.png?raw=true" width="128" />
</p>

| Latest Stable Release | Upstream URL |
| :---: | :---: |
| [Click here](https://github.com/pkgforge-dev/opencode-AppImage-Enhanced/releases/latest) | [Click here](https://github.com/anomalyco/opencode) |

</div>

Improved AppImage of opencode **independent of the host libc** which makes able to work on very very old distros as well as musl-libc distros like alpine linux.

* `opencode-cli` is also included, to use it you can do the following: 

```
# change argv0 to opencode-cli (similar to how busybox works)
ln -s ./OpenCode-*.AppImage ./opencode-cli
./opencode-cli

# or pass opencode-cli as $1
./OpenCode-*.AppImage opencode-cli
```

---

AppImage made using [sharun](https://github.com/VHSgunzo/sharun) and its wrapper [quick-sharun](https://github.com/pkgforge-dev/Anylinux-AppImages/blob/main/useful-tools/quick-sharun.sh), which makes it extremely easy to turn any binary into a portable package reliably without using containers or similar tricks. 

**This AppImage bundles everything and it should work on any Linux distro, including old and musl-based ones.**

This AppImage doesn't require FUSE to run at all, thanks to the [uruntime](https://github.com/VHSgunzo/uruntime).

This AppImage is also supplied with a self-updater by default, so any updates to this application won't be missed, you will be prompted for permission to check for updates and if agreed you will then be notified when a new update is available.

Self-updater is disabled by default if AppImage managers like [am](https://github.com/ivan-hc/AM), [soar](https://github.com/pkgforge/soar) or [dbin](https://github.com/xplshn/dbin) exist, which manage AppImage updates.

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/d40067a6-37d2-4784-927c-2c7f7cc6104b" alt="Inspiration Image">
  </a>
</details>

---

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/)
