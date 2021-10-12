# Promoscreens Backend Setup

Set up the Promoscreen by logging in to the backend with your credentials. *(?Source of credentials?)*<br/>
Login: [Promoscreens Backend](https://promoscreens-stage.sonepar.ch/auth/login)<br/>

*? Create a User and get the Username/Mail and API TOKEN. ?* <br/>

*? Other steps to do ?*

# Setup Raspberry Pi

## Hardware

```
- Raspberr Pi Official USB-C Power Supply
- Raspberry PI 4 Computer, Model B 8GB RAM
- PureLink CInema Seriers Micro HDMI - HDMI Cable (CS1200-030)
- SandDisk Extreme Plus 32GB
```

## Image
For the stable raspios 32bit (armhf) image go to [raspberrypi.org ](https://downloads.raspberrypi.org)  and Download the newest version of the **raspios_armhf** image.

```
https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2021-05-28/2021-05-07-raspios-buster-armhf.zip
```
*(Instructions Tested under version: raspios_armhf-2021-05-28)*

Unpack the File and continue with the unpacked "2021-05-07-raspios-buster-armhf.img" image.

## Pi Imager

Install Raspberry Pi OS by Flash the downloaded image onto an clean microSD card.
Use flashing software like: Raspberry Pi Imager or balenaEtcher

- [Raspberry Pi Imager](https://www.raspberrypi.org/software/)
- [balenaEtcher](https://www.balena.io/etcher/)

<br/>



# Image Setup

For setting up the Device, open the just flashed microSD card drive now *showing as "boot" drive*. 
Befor removing the sd and the first boot the image needs the following steps.

## Device config.txt

Inside the boot folder directory find **config.txt** and replace the file with the [config.txt](config.txt) from this repo. 

*(**Note**: Currently, the device setup is intended for wired LAN connections. The config disables: wifi, bluetooth and sound on the device.)*
## Setup SSH-Access

For headless setup, SSH can be enabled by placing a file named ssh, without any extension, onto the boot partition of the SD card. This will activate SSH on the Pi.

**host** => raspberrypi.local <br/>
**username** => pi <br/>
**paswword** => raspberry <br/>

Connect via ssh terminal:
```
ssh pi@raspberrypi.local
```

#### **Removing local cached fingerpint for IP on your device**
In case you already used the raspberrypi device with an SSH conection to the pies IP before, 
you may get an SSH Key Error. Resolve this error by removeing the cached fingerprint on your machine.

```
ssh-keygen -R 192.168.1.2  #Local IP of your Raspberry-Pi.
```


# Device Setup

Finally remove the flashed & configered microSD card from your machine and insert it into the Raspberry-Pi. 
Following Steps take place on the Raspberry-Pi device.

When using the setup with gui:

On first boot follow the gui SetUp guide.
- Set password for user on raspberry-pi.
<!-- - Set up WIFI.  -->

## Firmeware Update
Befor starting, install Update the Pies dependencies and packages.

```
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get update
```
```
sudo rpi-eeprom-update
sudo rpi-eeprom-update -a
```

## Installation

### Prerequisites

#### Install Chromedriver and Selenium

#### Pre Install needed packages.

To run and install all Divers install needed dependencies on to the Pi.
```
sudo apt-get install -y curl unzip xvfb libxi6 libgconf-2-4
sudo apt-get install libgles2-mesa libgles2-mesa-dev xorg-dev

```
# Browser
# Driver
<!-- _This could need a bit more improvment, if you run in to problems -> @TrevisGordan_ -->

### Configuration

#### Sleep Mode (manually)

- disable sleep mode display

# Raspi Config

To open the Raspi configuration enter in Terminal:

```
sudo raspi-config
```

This will open Terminal Settings. <br/><br/>
Inside Raspi Configuration config following: 
#### **Set Video Resolution to 1920x1080/60hz**

Einstellungen → Screen Configuration

#### **GL Driver**

Advanced Options → GL Driver → G2 GL (Fake KMS)

#### **<u>Disable</u> the compositor.**

Advanced Options → Compositor → No

### Reboo and Check 3D Drivers

After making the changes reboot the Pi.
```
sudo reboot
```

After reboot check if settings took effect.

```
cat /proc/device-tree/soc/firmwarekms@7e600000/status
cat /proc/device-tree/v3dbus/v3d@7ec04000/status
```

If both commands return okay, then the hardware acceleration is working and activated.

### Chrome

##### Plugins

Chromium on Raspberry Pi OS comes with uBlock Origin and h264ify extensions installed by default. Make sure that h264ify
is enabled, so YouTube uses h264-encoded videos for which the Raspberry Pi supports hardware-accelerated video decode.<br/>
Additional sources: <br/>
[How to enable hardware acceleration](https://www.linuxuprising.com/2021/04/how-to-enable-hardware-acceleration-in.html) <br/>
[How to make your raspberry pi 4 faster](https://medium.com/for-linux-users/how-to-make-your-raspberry-pi-4-faster-with-a-64-bit-kernel-77028c47d653) <br/>
[Raspberry Pi 4 video acceleration decode chromium](https://lemariva.com/blog/2020/08/raspberry-pi-4-video-acceleration-decode-chromium) <br/>


### Enable Chrome Flags:

To enhance the Chrome browser performance. You have to enable some Chrome-Flags inside the Browser.
To do that enter following Chrome URLs inside the URL bar and: <br/>

<!-- **Enable:** `chrome://flags/#ignore-gpu-blocklist`<br/> -->
<!-- **Enable:** `chrome://flags/#enable-gpu-rasterization`<br/> -->
<!-- **Enable:** `chrome://flags/#enable-accelerated-video-decode`<br/> -->
**enable:** [chrome://flags/#ignore-gpu-blocklist](chrome://flags/#ignore-gpu-blocklist) <br/>
**enable:** [chrome://flags/#enable-gpu-rasterization](chrome://flags/#enable-gpu-rasterization) <br/>
**enable:** [chrome://flags/#enable-accelerated-video-decode](chrome://flags/#enable-accelerated-video-decode) <br/>

To check the Chrome browser Graphics Feture Status enter: [chrome://gpu](chrome://gpu)<br/>
*All fetures should show a green status Text (except Vulkan).*

### Clone Github Repository

Make sure you have a ssh public key and have access to the repository

```
ssh-keygen
cat ~/.ssh/id_rsa.pub
```
Clone this Repo as scripts folder.
```
git clone https://github.com/codebar-ag/raspberry-pi-kiosk-32bit scripts 
```
then enter the scripts folder.
```
cd scripts
```
Inside the Repo (scripts folder):
### Install Pyhton Dependencies


On raspi os explicitly use '**python3**' & '**pip3**' commands to call python. run:
```
pip3 install -r requirements.txt
```

### Set Up the Config.

To use autostart config has to be set up correctly.<br/>
_NOTE! SECRETS SHOULD NOT BE VISIBLE IN GIT AND USED WITH ENV VARS._

Add the enviroment Variable AUTH_TOKEN with the right AuthToken to the scripts Current Working Directory (CWD, where the autostart.py is located). <br/> 

There are two Ways:

#### **I.  Make use of the .env File** 
! ADD SCREENURL_BASE env too!
By renaming the provided templatefile **.env.dist** to **.env** or creating your own then edit the .env file.
Uncomment the `AUTH_TOKEN=""`, `AUTH_USER=""` lines and insert your credentials at the placeholder accordingly. 
Make sure to set your correct base url in `SCREENURL_BASE=""`.  <br/>
Note: Only set the base url without paths - especially **dont** use any '/api/identification' path.
<br/> For more information about the AUTH Process with the Promoscreens Backend see the [API Dokumentation](https://documenter.getpostman.com/view/1711474/TzY3AaiV) <br/>  
In terminal use:

```bash
cp .env.dist .env   # rename env file with cp
nano .env           # edit the .env file 
```
Inside the File:
```bash
#MY_ENV_VAR="This is my env var content."
SCREENURL_BASE="< PLACE BASE URL eg. https://promoscreens.yourdomain.com >"
AUTH_USER="<PLACE YOUR USER EMAIL HERE>"
AUTH_TOKEN="<PLACE YOUR TOKEN HERE>"
```

The Config script will automaticly load the token and other environment variables from the env. file to
the config.yaml.


#### **II.  Add the Environment Variables with export** 
Inside the Scripts CWD run:
```bash
export SCREENURL_BASE="< PLACE BASE URL >"
export AUTH_USER="<PLACE YOUR USER EMAIL HERE>"
export AUTH_TOKEN="<PLACE YOUR TOKEN HERE>" # add environment variable to CWD
```
### Python Autostart Script

To start the autostart python script automaticly after every boot add it to the Pi´s boot scripts at lxsession.

```bash
sudo nano /etc/xdg/lxsession/LXDE-pi/autostart
```

*WARNING*: The Current Working Director of the script is the autostart directory!
Change one directory up to autostart folder.

```
cd /home/pi/Scripts/autostart
```

then run with **python3**

```python
python3 autostary.py
```


autostart will open the chromium in Fullscreen kioskmode.

_Note: To exit the kioskmode close it with ALT+F4_
<br/> <br/> <br/> 


## Common Exceptions:
Common Exceptions on running the python script.

### Wrong Driver Version
If you run the python script and receive:<br/> <br/> 
**Errors:**
```python
selenium.common.exceptions.SessionNotCreatedException: Message: session not created: This version of ChromeDriver only supports Chrome version 93
Current browser version is 88.0.4324.187 with binary path /usr/bin/chromium-browser
```
This means: Your Browser and Driver versions are different and do not match.
in this example the ChromeDriver only supports Chrome-Browser version 93. And you have version 88 Installed.

### Wrong Driver Binary
If you run the python script and receive:<br/> <br/> 
**OSErrors:**
```python
OSError: [Errno 8] Exec format error: 'chromedriver'
```
run: ```which chromedriver``` If this returns
```
bash: /usr/bin/chromedriver: cannot execute binary file: Exec format error
```
This means: you possibly installed a false chromedriver architecture binary. eg. ia32 instead of needed armv7l.
Delete the chromedriver binary and dowload the right armv7l binary version.