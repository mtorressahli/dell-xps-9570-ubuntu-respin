This repo is forked and adapted to personal needs from JackHack96's version. If you happen to be here, you should know this is not meant to be shared, but if you find something useful, take it. I try to keep it working for myself, but it is by no means rigorously revised and documented. This is from the original repo:

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/matteoiervasi)
[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/dell-xps-9570-ubuntu-respin/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link)

Now, to the thing:

# DELL XPS 15 9570 Ubuntu post installation script (18.04,19.04 and 19.10)

### Table of Contents
1. [Post-install script](#post-install-script)
2. [Switching from one graphic card to the other](#how-to-switch-from-one-graphic-card-to-the-other)
3. [Troubleshooting](#troubleshooting)

Collection of scripts and tweaks to make Ubuntu 18.04/19.04/19.10 run smooth on Dell XPS 15 9570 (and the software I use).
JackHack96 suggests everyone to use the post install method, the respun ISO is no longer (Nov 2019) supported nor neeeded for booting Ubuntu on 9570 as the stock one contains the needed fixes.

All informations, tips and tricks was gathered from:

- [tomwwright gist for DELL XPS 15 9560](https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880)
- [Atheros wifi card fix](https://ubuntuforums.org/showthread.php?t=2323812&page=2)
- [Respin script and info](http://linuxiumcomau.blogspot.com/)
- Myself [JackHack96] xD
- Myself :)

Kudos and all the credits for things not related to my work go to developers and users on those pages!

### What works out-of-the-box
 - ✅ Atheros Wifi
 - ✅ Audio
 - ✅ Audio on HDMI
 - ✅ HDMI ( even on lid closed )
 - ✅ Nvidia/Intel graphic cards switch
 - ✅ Keyboard backlight
 - ✅ Display brightness
 - ✅ Sleep/wake on Intel

### What doesn't work properly
 - ➖ Sleep/wake on nVidia

### What doesn't work
 - ❌ Goodix Fingerprint sensor

## Post-install script
If you already have a standard Ubuntu install, you can try applying basic tweaks with the `xps-tweaks.sh` script.
You can run it directly without cloning the repository with the following command (requires `curl`):
```shell
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/mtorressahli/dell-xps-9570-ubuntu-respin/master/xps-tweaks.sh)"
```

This is my own software script... with not much logic but need and preference (also requires `curl`):
```shell
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/mtorressahli/dell-xps-9570-ubuntu-respin/master/xps-software.sh)"
```

If you want touchpad gestures using X11, check https://github.com/bulletmark/libinput-gestures or better https://github.com/iberianpig/fusuma.

## How to switch from one graphic card to the other
Starting from nVidia 435 drivers, we can finally offload apps like on Windows without having to use very complicated setups with Bumblebee.
If during the script you chose to not enabling offloading, you can use the classic `prime-select` command:

**Intel**:
```
sudo prime-select intel
```
**Nvidia**:
```
sudo prime-select nvidia
```

**Note: A full reboot could be required when switching graphic cards.**

## Troubleshooting

Check the [wiki page](https://github.com/JackHack96/dell-xps-9570-ubuntu-respin/wiki/Troubleshooting) about it.
