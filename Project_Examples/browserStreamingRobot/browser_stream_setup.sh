echo "  _____            _                                ";
echo " |  __ \          | |                               ";
echo " | |  | | _____  _| |_ ___ _ __                     ";
echo " | |  | |/ _ \ \/ / __/ _ \ '__|                    ";
echo " | |__| |  __/>  <| ||  __/ |                       ";
echo " |_____/ \___/_/\_\\__\___|_| _        _            ";
echo " |_   _|         | |         | |      (_)           ";
echo "   | |  _ __   __| |_   _ ___| |_ _ __ _  ___  ___  ";
echo "   | | | '_ \ / _\` | | | / __| __| '__| |/ _ \/ __|";
echo "  _| |_| | | | (_| | |_| \__ \ |_| |  | |  __/\__ \ ";
echo " |_____|_| |_|\__,_|\__,_|___/\__|_|  |_|\___||___/ ";
echo "                                                    ";
echo "                                                    ";
echo " "
printf "Welcome to GoPiGo Browser Streaming Bot Installer.\nPlease ensure internet connectivity before running this script.\n
NOTE: Raspberry Pi wil reboot after completion."
echo "Must be running as Root user"
echo " "
echo "Press ENTER to begin..."
read

echo " "
echo "Check for internet connectivity..."
echo "=================================="

#Installing Mjpeg streamer http://blog.miguelgrinberg.com/post/how-to-build-and-run-mjpg-streamer-on-the-raspberry-pi
sudo apt-get update
sudo apt-get install libjpeg8-dev imagemagick libv4l-dev
sudo apt-get install cmake
sudo ln -s /usr/include/linux/videodev2.h /usr/include/linux/videodev.h
git clone https://github.com/jacksonliam/mjpg-streamer
cd mjpg-steamer
cd mjpg-streamer-experimental
sudo make
sudo make install
sudo cp mjpg_streamer /usr/local/bin
sudo cp output_http.so input_file.so /usr/local/lib/
sudo cp -R www /usr/local/www
mkdir /tmp/stream
cd ../../

git clone https://github.com/DexterInd/userland.git

cd userland
mkdir build
cd build
sudo apt-get install gcc build-essential cmake vlc rpi-update
cmake ../
make
sudo make install
cd ../../
rm -R userland

git clone https://bitbucket.org/DexterIndustries/raspberry_pi_camera_streamer
cd raspberry_pi_camera_streamer
mkdir build
cd build
cmake ../
make
sudo make install
cd ../../

rm -R raspberry_pi_camera_streamer

sudo pip install tornado
git clone https://github.com/DexterInd/sockjs-tornado.git
cd sockjs-tornado
sudo python setup.py install
cd ..
rm -R sockjs-tornado

echo " "
echo "Restarting"
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
shutdown -r now
