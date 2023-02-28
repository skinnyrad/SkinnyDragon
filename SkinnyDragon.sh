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

echo
echo "** PLEASE READ THIS NOTICE**"
echo "Everytime you boot DragonOS for now on, you will be prompted to make a new password."
echo "During this process, it always prompt you for the Current Password"
echo "When prompted for the Current Password, it will always be blank."
echo "Simply press ENTER at this prompt and it will then ask you for the new password."
echo
echo "Press Enter to continue"
read key

echo "**** Creating Password Prompt on Login ****"
cd ~
mkdir myScripts
cd myScripts
echo '#!/bin/bash' > passwordchange.sh
echo 'echo "*** Create a Password for This Session ***"' >> passwordchange.sh
echo 'echo "At the Current Password prompt, press ENTER."' >> passwordchange.sh
echo "passwd" >> passwordchange.sh
chmod 744 passwordchange.sh

cd ~/.config/
mkdir autostart
cd autostart
echo "[Desktop Entry]" > password.desktop
echo "Type=Application" >> password.desktop
echo "Exec=/home/live/myScripts/passwordchange.sh" >> password.desktop
echo "Terminal=true" >> password.desktop
echo "StartupNotify=true" >> password.desktop
echo "Name=Password" >> password.desktop
chmod 744 password.desktop

echo
echo "**** Desktop Download for Class Background ****"
echo
wget https://skinnyrd.com/wp-content/uploads/2023/02/Screensaver.png -P ~/Pictures/
cd ~/Pictures/
mv Screensaver.png wallpaper.png
cd ~/.config/autostart
echo "[Desktop Entry]" > wallpaper.desktop
echo "Type=Application" >> wallpaper.desktop
echo "Exec=pcmanfm-qt --set-wallpaper=/home/live/Pictures/wallpaper.png --wallpaper-mode=stretch" >> wallpaper.desktop
echo "Name=Wallpaper" >> wallpaper.desktop

echo "**** Please reboot by typeing reboot and pressing ENTER ****"
