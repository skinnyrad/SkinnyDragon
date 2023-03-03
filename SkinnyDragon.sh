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

echo "**** Installing Blue Sonar ****"
cd ~
git clone https://github.com/ZeroChaos-/blue_sonar
echo

echo "**** Creating Permanent aliases for Blue_Hydra & Blue Sonar ****"
cd ~
echo "alias blue_hydra='sudo /opt/bluetooth/blue_hydra/bin/blue_hydra'" > .bash_aliases
echo "alias blue_sonar='sudo ~/blue_sonar/blue_sonar'" >> .bash_aliases
echo

echo
echo "** PLEASE READ THIS NOTICE **"
echo "When DragonOS boots, you will be prompted to make a new user password."
echo "During this process, it always prompts for the Current Password."
echo "When prompted for the Current Password, press ENTER because the password does not exist."
echo "Any new password created will be erased each time DragonOS shuts down."
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
wget https://skinnyrd.com/wp-content/uploads/2023/03/DragonWallpaper1080turq.png -P ~/Pictures/
wget https://skinnyrd.com/wp-content/uploads/2023/03/DragonWallpaper1080red.png -P ~/Pictures/
wget https://skinnyrd.com/wp-content/uploads/2023/03/DragonWallpaper1080skeleton.png -P ~/Pictures/
wget https://skinnyrd.com/wp-content/uploads/2023/03/DragonWallpaper1080grey.png -P ~/Pictures/
echo -ne "
Choose your destiny:
1) The Flowing Stream
2) The Endless Sun
3) The Dark Spectre
4) The Drifting Cloud

Choose a number and press ENTER:  "
    read -r ans
    case $ans in
    1)
        a='turq'
        ;;
    2)  
        a='red'
        ;;
    3)
        a='skeleton'
        ;;
    4)  
        a='grey'
        ;;
    *)  
        echo
        echo "Your destiny has been chosen for you."
        echo
        a='turq'
        ;;
    esac
cd ~/.config/autostart
echo "[Desktop Entry]" > wallpaper.desktop
echo "Type=Application" >> wallpaper.desktop
echo "Exec=pcmanfm-qt --set-wallpaper=/home/live/Pictures/DragonWallpaper1080$a.png --wallpaper-mode=center" >> wallpaper.desktop
echo "Name=Wallpaper" >> wallpaper.desktop
chmod 744 wallpaper.desktop
pcmanfm-qt --set-wallpaper=/home/live/Pictures/DragonWallpaper1080$a.png --wallpaper-mode=center

echo
echo "**** Erasing qterminal Config Files for Clean Reboot ****"
echo
rm -rf ~/.config/qterminal.org/

echo
echo "**** A Reboot Will Occur in 10 Seconds ****"
echo
sleep 5
echo "5 seconds remaining..."
sleep 5
reboot
