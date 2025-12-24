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
export OPTIMIZE_LAUNCH=1

# Deploy dependencies
quick-sharun /usr/bin/graphs \
             /usr/lib/libgirepository*

# Set Graphs to use AppImage's directory
echo 'GRAPHS_DEVEL_PATH=${SHARUN_DIR}/share/graphs' >> ./AppDir/.env
echo 'GRAPHS_OVERRIDE_RESOURCES=${SHARUN_DIR}/share/graphs/se.sjoerd.Graphs.gresource' >> ./AppDir/.env
echo 'GRAPHS_OVERRIDE_LOCALEDIR=${SHARUN_DIR}/share/locale' >> ./AppDir/.env

# Turn AppDir into AppImage
quick-sharun --make-appimage
