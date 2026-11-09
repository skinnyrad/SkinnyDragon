#!/bin/bash

#Version numbers for software
MAYHEM_VER=v2.4.0
TSCMCD_VER=v1.2.0
HACKRF_VER=2026.01.3
ECHOBL_VER=v0.1.2

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
echo
echo "**** Moving Scripts Into Place ****"
cd ~/SkinnyDragon
mv myScripts ~

echo
echo "**** Installing Tools ****"
sudo apt update
sudo apt -y install bluez-tools openssh-server libbluetooth3 libbluetooth-dev build-essential cmake pkg-config libbtbb-dev libliquid-dev python3.14-venv

echo
echo "**** Installing Kismet ****"
# Install git release of kismet
wget -O - https://www.kismetwireless.net/repos/kismet-release.gpg.key --quiet | gpg --dearmor | sudo tee /usr/share/keyrings/kismet-archive-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/kismet-archive-keyring.gpg] https://www.kismetwireless.net/repos/apt/git/resolute resolute main' | sudo tee /etc/apt/sources.list.d/kismet.list >/dev/null
sudo apt update
sudo apt install -y kismet
sudo usermod -aG kismet $USER
sudo usermod -aG dialout $USER

echo
echo "**** Installing Blue Sonar ****"
cd ~
git clone https://github.com/ZeroChaos-/blue_sonar
echo

echo "**** Installing Redfang ****"
cd ~
git clone https://gitlab.com/kalilinux/packages/redfang
cd ~/redfang
make
echo

echo "**** Installing UAPfuzz ****"
cd ~
git clone https://github.com/skinnyrad/uapfuzz
echo

echo "**** Installing UTS-Script-Show ****"
cd ~
git clone https://github.com/skinnyrad/UTS-Script-Shop
chmod 744 ~/UTS-Script-Shop/Ubertooth/ubersort.sh
echo

echo "**** Installing EchoBlue ****"
cd ~
wget "https://github.com/skinnyrad/echoblue/releases/download/${ECHOBL_VER}/echoblue-${ECHOBL_VER}-linux-amd64 -O ~/Downloads/echoblue
mkdir ~/echoblue
sudo cp ~/Downloads/echoblue ~/usr/local/bin/echoblue

echo "**** Installing Supertooth ****"
cd ~
wget https://github.com/daltoncox/supertooth/releases/latest/download/supertooth_linux_amd64.deb -O ~/Downloads/supertooth_linux_amd64.deb
sudo apt -y install ~/Downloads/supertooth_linux_amd64.deb
echo

echo "**** Installing TSCM Change Detection ****"
cd ~/Downloads
wget "https://github.com/skinnyrad/TSCM-Change-Detection/releases/download/${TSCMCD_VER}/tscm-change-detection_${TSCMCD_VER}_linux_amd64.tar.gz"
sudo tar -C /usr/local/bin -xzf tscm-change-detection_${TSCMCD_VER}_linux_amd64.tar.gz
sudo chmod +x /usr/local/bin/tscm-change-detection || true
echo

echo "**** Patching HackRF Spectrum Analyzer launch icon****"
echo "Change just launches terminal window."
cd ~
HRFSA_FILEPATH="/usr/share/applications/hackrf-spectrum-analyzer.desktop"
NEW_EXEC="Exec=qterminal -w /usr/src/hackrf-spectrum-analyzer/"
sudo sed -i "s|^Exec=.*|$NEW_EXEC|" "$HRFSA_FILEPATH"
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
echo "alias echoblue='~/echoblue/echoblue'" >> .bash_aliases
echo

echo "**** Downloading HackRF and Mayhem Firmware ****"
echo
read -p "Do you want to download the MAYHEM and HackRF firmware? If yes, this could take awhile on a slow connection. Select y or n: " reply
case "${reply,,}" in
    y | yes )
        wget https://github.com/greatscottgadgets/hackrf/releases/download/v${HACKRF_VER}/hackrf-${HACKRF_VER}.zip -O ~/Downloads/hackrf-${HACKRF_VER}.zip
        wget https://github.com/portapack-mayhem/mayhem-firmware/releases/download/${MAYHEM_VER}/COPY_TO_SDCARD_hackrf_mayhem_${MAYHEM_VER}.zip -O ~/Downloads/COPY_TO_SDCARD_hackrf_mayhem_${MAYHEM_VER}.zip
        wget https://github.com/portapack-mayhem/mayhem-firmware/releases/download/${MAYHEM_VER}/FIRMWARE_mayhem_"${MAYHEM_VER}".zip -O ~/Downloads/FIRMWARE_mayhem_${MAYHEM_VER}.zip
        ;;
    n | no )
        echo "Download canceled."
        ;;
    * )
        echo "Invalid response. Exiting."
        ;;
esac
echo

echo "**** Creating an autostart for the Startup Script ****"
cd ~/.config/
mkdir autostart
cd autostart
echo "[Desktop Entry]" > startup.desktop
echo "Type=Application" >> startup.desktop
echo "Exec=~/myScripts/startup.sh" >> startup.desktop
echo "Terminal=true" >> startup.desktop
echo "StartupNotify=true" >> startup.desktop
echo "Name=StartUp" >> startup.desktop
echo "X-LQXt-Need-Tray=true">> startup.desktop
chmod 744 startup.desktop

echo
echo "**** Downloading Desktop for Class Background ****"
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

pcmanfm-qt --set-wallpaper="/home/live/Pictures/DragonWallpaper1080$a.png" --wallpaper-mode=stretch
echo
echo "Oh, really. I see. Contemplating your decision..."
echo
sleep 20

echo
echo "**** A Reboot Will Occur in 10 Seconds ****"
echo
sleep 10
echo "5 seconds remaining..."
sleep 5
shutdown now
