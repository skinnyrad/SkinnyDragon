# SkinnyDragon
![DragonWallpaper1080turq](https://user-images.githubusercontent.com/20311289/222309740-bc611523-16c6-4f3e-9b08-7aabdec38366.png)

Skinny Dragon is a custom load for the DragonOS live version. 

## Installation
Be sure to download the latest version of [DragonOS](https://sourceforge.net/projects/dragonos-focal/) and burn the iso to a USB drive. I use [Rufus](https://rufus.ie/en/) because the live USB version needs to have a persistent partition. Rufus provides the ability to supply such a partition without much of a hassle. Give 75% to 90% of the allowed persistent space to the persistent partition. With this partition present you will be able to save many of your changes from session to session.

When booted into the live USB session, bring up a terminal window and type the following pressing ENTER after each command.
```
git clone https://github.com/skinnyrad/SkinnyDragon
cd SkinnyDragon
./SkinnyDragon
```

## Software Installed
- [Blue Sonar](https://github.com/ZeroChaos-/blue_sonar)
- bluez-tools
- HackRF Firmware (Downloads folder)
- Mayhem Firmware for HackRF (Downloads folder)
- Openssh Server
- [Red Fang](https://gitlab.com/kalilinux/packages/redfang)
- [UAPfuzz](https://github.com/skinnyrad/uapfuzz)
- [UTS-Script-Shop](https://github.com/skinnyrad/UTS-Script-Shop)

## Aliases
Blue Hydra, Blue Sonar, Red Fang have been aliased so that you do not need to use sudo to run. Just type the base command and press enter.

Full Alias List:
- blue_hydra='sudo /opt/bluetooth/blue_hydra/bin/blue_hydra'
- blue_sonar='sudo ~/blue_sonar/blue_sonar'
- fang='sudo ~/redfang/fang'
- uapfuzz='~/uapfuzz/uapfuzz.sh'
- rewifi='sudo systemctl restart NetworkManager'
- KismetParse='python3 ~/UTS-Script-Shop/Kismet/KismetParse.py'
- sort_and_format='~/UTS-Script-Shop/Ubertooth/sort_and_format.sh'
- add_targets='~/UTS-Script-Shop/Kismet/add_targets.sh'


## Password Prompt
In order to use the openssh functionality, one must have a password. However, everytime the live version is rebooted, the password is erased. After running the installation script, a prompt will appear at each subsequent reboot to ask for a new password. The password given to the prompt will be kept until the computer is rebooted or shutdown. When asked for the current password, leave it blank and press ENTER. DragonOS does not have a password for the live user by default.
