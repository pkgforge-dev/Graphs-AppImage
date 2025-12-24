#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q graphs | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/se.sjoerd.Graphs.svg
export DESKTOP=/usr/share/applications/se.sjoerd.Graphs.desktop
export DEPLOY_SYS_PYTHON=1
export DEPLOY_GTK=1
export GTK_DIR=gtk-4.0
export ANYLINUX_LIB=1
export DEPLOY_LOCALE=1
export STARTUPWMCLASS=se.sjoerd.Graphs # Default to Wayland's wmclass. For X11, GTK_CLASS_FIX will force the wmclass to be the Wayland one.
export GTK_CLASS_FIX=1

# Deploy dependencies
quick-sharun /usr/bin/graphs \
             /usr/lib/libgirepository*

# Patch Graphs to use AppImage's directory
sed -i '/if __name__ == "__main__":/a \
    SHARUN_DIR = os.getenv('"'"'SHARUN_DIR'"'"')' ./AppDir/bin/graphs
sed -i 's|graph_path_dir = "/usr/share/graphs"|graph_path_dir = os.path.join(SHARUN_DIR, "/share/graphs")|' ./AppDir/bin/graphs
sed -i 's|localedir = "/usr/share/locale"|localedir = os.path.join(SHARUN_DIR, "/share/locale")|' ./AppDir/bin/graphs
sed -i 's|gresource_location = os.path.join("/usr/share/graphs", "se.sjoerd.Graphs.gresource")|gresource_location = os.path.join(graph_path_dir, "se.sjoerd.Graphs.gresource")|' ./AppDir/bin/graphs

# Turn AppDir into AppImage
quick-sharun --make-appimage
