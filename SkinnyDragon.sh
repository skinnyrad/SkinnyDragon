#!/bin/bash

#Mayhem version has a v in front of version number
MAYHEM_VER=v2.1.0
HACKRF_VER=2024.02.1

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
sudo apt-get -y install bluez-tools openssh-server libbluetooth-dev
echo

echo "**** Installing Blue Sonar ****"
cd ~
git clone https://github.com/ZeroChaos-/blue_sonar
echo

echo "**** Install Redfang ****"
cd ~
git clone https://gitlab.com/kalilinux/packages/redfang
cd ~/redfang
make
echo

echo "**** Install UAPfuzz ****"
cd ~
git clone https://github.com/skinnyrad/uapfuzz
echo

echo "**** Install UTS-Script-Show ****"
cd ~
git clone https://github.com/skinnyrad/UTS-Script-Shop
chmod 744 ~/UTS=Script-Shop/Ubertooth/ubersort.sh
echo

echo "**** Patching BlueHydra Gem (if needed) ****"
cd ~
GEM_INFO=$(gem list -d data_objects 2>/dev/null)

if [[ -n "$GEM_INFO" ]]; then
    VERSION=$(echo "$GEM_INFO" | awk '/data_objects \([0-9.]+\)/ {gsub(/[()]/, "", $2); print $2}')
    INSTALL_DIR=$(echo "$GEM_INFO" | awk '/Installed at:/ {print $3}')
    # Only proceed if version is less than or equal to 0.10.17
    if [ "$(printf "%s\n0.10.17" "$VERSION" | sort -V | head -n1)" = "$VERSION" ]; then
        echo "Patching data_objects version $VERSION..."
        if cd "$INSTALL_DIR/gems/data_objects-$VERSION" 2>/dev/null; then
            if sudo wget https://pentoo.org/~zero/data_objects-fixnum2integer.patch; then
                if sudo patch -p1 < data_objects-fixnum2integer.patch; then
                    echo "Patch applied successfully"
                else
                    echo "Error: Patch failed"
                fi
            else
                echo "Error: Failed to download patch"
            fi
        else
            echo "Error: Could not change to gem directory"
        fi
    else
        echo "Info: data_objects version $VERSION does not require patching"
    fi
else
    echo "Warning: data_objects gem not installed"
fi
echo

echo "**** Creating Permanent Aliases for Blue_Hydra, Blue Sonar, Red Fang, Uapfuzz, restart for Network Manager, KismetParse, and Ubersort ****"
cd ~
echo "alias blue_hydra='sudo /opt/bluetooth/blue_hydra/bin/blue_hydra'" > .bash_aliases
echo "alias blue_sonar='sudo ~/blue_sonar/blue_sonar'" >> .bash_aliases
echo "alias fang='sudo ~/redfang/fang'" >> .bash_aliases
echo "alias uapfuzz='~/uapfuzz/uapfuzz.sh'" >> .bash_aliases
echo "alias rewifi='sudo systemctl restart NetworkManager'" >> .bash_aliases
echo "alias KismetParse='python3 ~/UTS-Script-Shop/Kismet/KismetParse.py'" >> .bash_aliases
echo "alias ubersort='~/UTS-Script-Shop/Ubertooth/ubersort.sh'" >> .bash_aliases

echo "**** Download HackRF and Mayhem Firmware ****"
wget https://github.com/greatscottgadgets/hackrf/releases/download/v$HACKRF_VER/hackrf-$HACKRF_VER.zip -O ~/Downloads/hackrf-$HACKRF_VER.zip
wget https://github.com/portapack-mayhem/mayhem-firmware/releases/download/$MAYHEM_VER/mayhem_"$MAYHEM_VER"_COPY_TO_SDCARD.zip -O ~/Downloads/mayhem_"$MAYHEM_VER"_COPY_TO_SDCARD.zip
wget https://github.com/portapack-mayhem/mayhem-firmware/releases/download/$MAYHEM_VER/mayhem_"$MAYHEM_VER"_FIRMWARE.zip -O ~/Downloads/mayhem_"$MAYHEM_VER"_FIRMWARE.zip

echo
echo "** PLEASE READ THIS NOTICE **"
echo "When DragonOS boots, you will be prompted to make a new user password."
echo "During this process, it always prompts for the Current Password."
echo "When prompted for the Current Password, press ENTER because the password does not exist."
echo "Any new password created will be erased each time DragonOS shuts down."
echo
echo "Press Enter to continue"
read key

echo "**** Creating Password Prompt Script ****"
cd ~
mkdir myScripts
cd myScripts
echo '#!/bin/bash' > passwordchange.sh
echo 'read -p "Do you want to create a password for this session (for use with SSH)? (yes/no): " answer' >> passwordchange.sh
echo 'case "$answer" in' >> passwordchange.sh
echo '  [Yy][Ee][Ss]|[Yy])' >> passwordchange.sh
echo '    echo "*** Create a Password for This Session ***"' >> passwordchange.sh
echo '    echo "At Current Password prompt, JUST PRESS ENTER."' >> passwordchange.sh
echo '    echo' >> passwordchange.sh
echo '    passwd' >> passwordchange.sh
echo '    ;;' >> passwordchange.sh
echo '  [Nn][Oo]|[Nn])' >> passwordchange.sh
echo '    exit 1' >> passwordchange.sh
echo '    ;;' >> passwordchange.sh
echo '  *)' >> passwordchange.sh
echo '    exit 1' >> passwordchange.sh
echo '    ;;' >> passwordchange.sh
echo 'esac' >> passwordchange.sh
chmod 744 passwordchange.sh

echo "**** Creating Password Prompt AutoLaunch at Login ****"
cd ~/.config/
mkdir autostart
cd autostart
echo "[Desktop Entry]" > password.desktop
echo "Type=Application" >> password.desktop
echo "Exec=/home/live/myScripts/passwordchange.sh" >> password.desktop
echo "Terminal=true" >> password.desktop
echo "StartupNotify=true" >> password.desktop
echo "Name=Password" >> password.desktop
echo "X-LQXt-Need-Tray=true">> password.desktop
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
