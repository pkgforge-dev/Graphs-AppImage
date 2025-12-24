# Graphs-AppImage 🐧

[![GitHub Downloads](https://img.shields.io/github/downloads/pkgforge-dev/Graphs-AppImage/total?logo=github&label=GitHub%20Downloads)](https://github.com/pkgforge-dev/Graphs-AppImage/releases/latest)
[![CI Build Status](https://github.com//pkgforge-dev/Graphs-AppImage/actions/workflows/appimage.yml/badge.svg)](https://github.com/pkgforge-dev/Graphs-AppImage/releases/latest)

<p align="center">
  <img src="https://gitlab.gnome.org/World/Graphs/-/raw/main/data/icons/hicolor/scalable/apps/se.sjoerd.Graphs.svg?ref_type=heads" width="128" />
</p>

* [Latest Stable Release](https://github.com/pkgforge-dev/Graphs-AppImage/releases/latest)

---

AppImage made using [sharun](https://github.com/VHSgunzo/sharun), which makes it extremely easy to turn any binary into a portable package without using containers or similar tricks. 

**This AppImage bundles everything and should work on any linux distro, even on musl based ones.**

This appimage works without fuse2 as it can use fuse3 instead, it can also work without fuse at all thanks to the [uruntime](https://github.com/VHSgunzo/uruntime)

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/29576c50-b39c-46c3-8c16-a54999438646" alt="Inspiration Image">
  </a>
</details>

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/)

## Known quirk
- Help page only works if `gnome-help` or other similar `.page` viewer is installed on the host's system.  
Bundling the help page viewer in the AppImage would make it work everywhere, but it's both bad for the file size and [security](https://blogs.gnome.org/mcatanzaro/2025/04/15/dangerous-arbitrary-file-read-vulnerability-in-yelp-cve-2025-3155/), hence why we don't do that.
  - `gnome-help` v49.0 doesn't work with Help section of our GTK AppImages for some reason, while older versions, like v42.3 work.
