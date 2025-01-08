# atLogic for Linux
This git repo contains an installer for Autonic's atLogic on linux as a `PlayOnLinux` script.
For now it has only been tested with atLogic v2.4.0.0 and it is restricted to that version,
but it is probably possible for it to work with other versions too. 

Same for wine, it uses version 18.1.0-cx because it works. You can always test other versions, but
there is a chance that not all the program features will work properly. For example, this installer 
used to install version 7.18, but it didn't allow PLCs to be connected via the serial port.

## Requirements and Installation
First of all you need an already working installation of 
[`PlayOnLinux`](https://www.playonlinux.com/en/) because the installer is a
PlayOnLinux bash script, and you need [`WatchDrop`](https://github.com/SuckDuck/WatchDrop) 
to solve some minor issue, not to mention that you should have already downloaded the atLogic V2.4.0.0 setup from
the official [Autonics](https://www.autonics.com/us/series/atLogic) site.

Once you have done that you can either clone this repo or download the **install.sh** script and the
**PlayOnLinux-atLogic-xml_fix.zip** fix file, make sure both files are in the same path.
Then open the **install.sh** and change the `PLAYONLINUX_PKG` var to the PlayOnLinux bin
name on your distro, I'm on arch right now so mine is playonlinux4 but don't know about other ones,
then you can change the other configurations if you want, for example the `WINE_VERSION` or the `PVERSION` 
if you want to try with other atLogic version (make sure to change the `INSTALLER_CHECKSUM` too if so).
If you are ready now then open PlayOnLinux and use the function **Run a local script** from the **Tools**
menu, select the **install.sh** script when asked and follow along, don't change the installation path and
uncheck th *Run atLogic* checkbox when finished, if you didn't uncheck it, it's ok but make sure to close the
program as it opens up.

## How to Run
Avoid running the program from the PlayOnLinux menu or desktop shortcut, as saving files will not work correctly
The correct way to run the program is from the script saved at `~/bin/atLogic`, the installer itself add that route 
to `$PATH` but if it didn't, make sure to add it from your .bashrc file.

PlayOnLinux also creates a shortcut on your desktop folder if one exists, you should not run the program from there either,
actually you should remove this file. If you want any shortcut to the desktop or some context menu you will have
to create it manually pointing to the ~/bin/atLogic script, and the process will depend on your desktop environment.

## Connect PLC via Serial Port
From [`Wine User's Guide/Other Things to Configure/Serial and Parallel Ports`](https://gitlab.winehq.org/wine/wine/-/wikis/Wine-User's-Guide#AEN715)
```
To override Wine's default device mapping, run wine regedit and create
string entries in HKEY_LOCAL_MACHINE\Software\Wine\Ports where the
entry name is the Windows device name and the entry value is the path to
the Unix device. Continuing with the above example, to make COM1 the
first USB-attached serial port, create an entry with the name COM1 and
the value /dev/ttyUSB0. You might also want to create an entry named
COM5 with no value to remove the COM5 device which is now a duplicate
of COM1. After editing the registry, shut down Wine with wineserver -k
and the next time Wine runs a program, your changes will take effect.
```

As PlayOnLinux is the one who manages the wine prefix for this program, you can find
it's regedit menu on the PlayOnLinux configuration section for this program, under the
wine tab.

Also, be sure to give your user the proper permissions to open the serial
port, you can do as follow:
```
sudo chmod a+rw /dev/tty[ your port ]
```

## Quirks
* The program has some Korean words here and there, and even with korean fonts installed, there are some strange characters
here and there, i don't know if in windows is the same way but i'm putting this here anyway.
* When you use the **save as** function, it doesn't matter where you place the file or what name you give it, it always
save the file in the same path with the same name and after that it gives an error dialog, if you select another thing than
"ignore" the program crashes, so be aware. WatchDrop is used as a workaround for this, in the moment where the program gives
you the error dialog, WatchDrop serve you a Save File dialog to choose where to save the file and with what name.

## Uninstall
You can uninstall the program from PlayOnLinux as any other PlayOnLinux program, but make sure to delete the `~/bin/atLogic` too.
