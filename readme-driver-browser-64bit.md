
# THIS PART IS ONLY FOR PI RUNNING 64bit Architecture.
#


# Browser
#### Pre Updates / Install chromium-browser

Install or Updates the chromium-browser.
To install the browser, you need to run the following command on your Raspberry Pi.
```
sudo apt-get install chromium-browser --yes
```
The Raspberry Pi 4 running 64bit architecture needs a special optimization version of chromium-browser due to its hardware.
This will install the version of the web browser that is provided from the Raspberry Pi OS repository.
This build of Chromium has special optimizations for the Raspberry Pi compiled into it.
The Driver is rarely updated since it is not maintained by chromium project.

<!-- Current version of chromium-browser is: 92.0.4515.98 -->

<!-- | Chromium-Browser  | chromedriver |
| ------------- | ------------- |
| 92.0.4515.98  | [v14.0.0](https://github.com/electron/electron/releases/tag/v14.0.0) |
| Content Cell  | Content Cell  |
https://github.com/electron/electron/releases/tag/v13.1.8 (Updated Chromium to 91.0.4472.164. #30169)
https://github.com/electron/electron/releases/tag/v14.0.0-beta.18 (Updated Chromium to 93.0.4577.15. #30029)
https://github.com/electron/electron/releases/tag/v14.0.0 (Chromium 93.0.4577.58.)
https://github.com/electron/electron/releases/tag/v13.0.0 (Chromium 91.0.4472.69) -->
# Driver
## Install chromedriver 
The Raspberry Pi 4 running 64bit architecture needs a special optimization version of ChromeDriver.
Get Chromedriver from [Electron GitHub releases](https://github.com/electron/electron/releases). Make sure it supports the installed chromium version on your Pie! <br/>  
Make sure you downloaded the right os version. <br/>*Check the "Other Changes" or "Stack Upgrades" section on the Version Release Notes for <br/> eg. Updated **Chromium to 94.0.4606.61.** part.* <br/> <br/> 
To get the needed versions for your chromium-browser installation <br/> 
<!-- Enter: &nbsp;&nbsp;&nbsp;&nbsp;`chromium --product-version` <br/>  -->
Enter: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`chromium-browser --product-version` <br/> 
And: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `chromedriver --product-version` <br/> 

 

**NOTE:** The 32bit RaspberryOS Image runs the **armv7l** architecture! <br/> 
→ You need need the "chromedriver-_VERSION_-linux-**armv7l**.zip" version file.

```
sudo wget https://github.com/electron/electron/releases/download/v14.1.0/chromedriver-v14.1.0-linux-armv7l.zip
unzip chromedriver-v14.1.0-linux-armv7l.zip
```
after the download unzip the driver.
Make sure to configure ChromeDriver on your system (move the chromedriver to /usr/lib)

```
sudo mv chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
```
After configureing the driver reboot the Pi.
```
sudo reboot
```


After this everything should be set up. 

### Removing wrong chromedriver version
**ONLY** In case you installed the wrong version of chromedriver. <br/>removing chrome driver:

```
sudo rm -f /usr/bin/chromedriver 
sudo rm -f /usr/local/bin/chromedriver 
sudo rm -f /usr/local/share/chromedriver
``` 

Helpful sources:<br/>
[Setup selenium with chromedriver](https://tecadmin.net/setup-selenium-with-chromedriver-on-debian/) <br/>
[How to run selenium using python](https://patrikmojzis.medium.com/how-to-run-selenium-using-python-on-raspberry-pi-d3fe058f011)

