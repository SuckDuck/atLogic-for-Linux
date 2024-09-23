#!/usr/bin/env playonlinux-bash

PLAYONLINUX_PKG="playonlinux4"
WINE_VERSION="7.18"
PREFIX="atLogic"
PVERSION="2.4.0.0"
XMLFIX="PlayOnLinux-atLogic-xml_fix.zip"
XMLFIX_CHECKSUM="6f46101afe3d4e57aa1b4402b33ed91d"
INSTALLER_CHECKSUM="e4e2eb0d81f19dc12b5944d372f433f1"
INSTALLDIR="$HOME/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program Files/Autonics/atLogic(DevENG)"

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
POL_SetupWindow_Init

POL_SetupWindow_browse "Select the $PREFIX $PVERSION installer" "Installer selection"
if ! echo "$INSTALLER_CHECKSUM $APP_ANSWER" | md5sum -c -
then
    POL_SetupWindow_message "The selected installer doesn't correspond to $PREFIX $PVERSION" "Error"
    POL_SetupWindow_Close
    exit 1
fi
INSTALLER=$APP_ANSWER

FIX_PATH="$(dirname "$INSTALLER")/$XMLFIX"
if ! echo "$XMLFIX_CHECKSUM $FIX_PATH" | md5sum -c -
then
    POL_SetupWindow_message "The xml fix file could not be found" "Error"
    POL_SetupWindow_Close
    exit 1
fi

POL_Wine_SelectPrefix $PREFIX
POL_Wine_PrefixCreate $WINE_VERSION 
POL_SetupWindow_wait "Installing" "Please wait"
POL_Wine "$INSTALLER"
POL_Shortcut "atLogic.exe" "atLogic"

unzip -o $FIX_PATH -d "$INSTALLDIR"
echo $PATH | grep -q "$HOME/bin" || echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
mkdir $HOME/bin
cd $HOME/bin
echo "#/bin/bash
watchdrop -me .ssp \"$INSTALLDIR\" $PLAYONLINUX_PKG --run atLogic" > ./atLogic
chmod u+x ./atLogic


POL_SetupWindow_message "Done" "Done"
POL_SetupWindow_Close
exit