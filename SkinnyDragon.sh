#!/bin/bash

echo "  ____  _    _                                  "
echo " / ___|| | _(_)_ __  _ __  _   _                "
echo " \___ \| |/ / | '_ \| '_ \| | | |               "
echo "  ___) |   <| | | | | | | | |_| |               "
echo " |____/|_|\_\_|_| |_|_| |_|\__, |    ___  ____  "
echo " |  _ \ _ __ __ _  __ _  __|___/__  / _ \/ ___| "
echo " | | | | '__/ _' |/ _' |/ _ \| '_ \| | | \___ \ "
echo " | |_| | | | (_| | (_| | (_) | | | | |_| |___) |"
echo " |____/|_|  \__,_|\__, |\___/|_| |_|\___/|____/ "
echo "                  |___/                         "

echo "*** Internet access is required ***"
echo
echo "Press ENTER to continue or Ctrl-C to exit:"

read key

sudo apt-get update
sudo apt-get -y install bluez-tools openssh-server

echo

echo "****Creating a Permanent alias for Blue_Hydra****"
echo
cd ~
echo "alias blue_hydra='sudo ~/blue_hydra/bin/blue_hydra'" > .bash_aliases
echo

echo "**** READ INSTRUCTIONS BELOW CAREFULLY ****"
echo "You will need to assign a password to this user. Everytime this computer reboots, the password will be erased."
echo "Your username is: live"
echo "Please follow the steps below to change the password."
echo "When prompted for the Current Password, just press Enter."
echo

passwd

echo "Now that you have entered a password, it will be valid for this session."
echo "To give yourself a password in the future, pop open the terminal and type: passwd"
echo "You will need a password if you wish to log in to this machine remotely using ssh."
read key
echo "Press Enter to continue"

echo
echo "**** Desktop Download for Class Background ****"
echo
wget https://skinnyrd.com/wp-content/uploads/2023/02/Screensaver.png -P ~/Pictures/
cd ~/Pictures/
mv Screensaver.png wallpaper.png
pcmanfm-qt -w wallpaper.png

echo "**** Please Reboot ****"
