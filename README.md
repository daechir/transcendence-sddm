# Author
Author: Daechir <br/>
Author URL: https://github.com/daechir <br/>
License: GNU GPL <br/>
Modified Date: 08/13/20 <br/>
Version: v1


## Purpose
Transcendence serves as a minimal SDDM theme adhering to the KISS principle.
This theme was built and tested on vanilla Arch Linux only. However it should also work on many other Linux distros as-well.
No screenshot is provided as I no longer use SDDM or any type of display manager.


## Options
Out of the box Transcendence supports four options:
+ displayHeight=1920
+ displayWidth=1080
+ displayFont="Roboto"
+ background=images/background.jpg

For the best results and performance make sure to add your display dimensions. <br/>
If you don't have Roboto installed you may install it in Arch Linux via "ttf-roboto." <br/>
As always you may change the default options to your specifications in theme.conf.


## Installation
Installing this theme is as simple as it gets. <br/>

### Arch Linux:
`sudo cp -R Transcendence /usr/share/sddm/themes/` <br/>
`sudo chmod -R 755 /usr/share/sddm/themes/Transcendence/` <br/>
`sudo sed -i "s/^Current=.*/Current=Transcendence/g" /usr/lib/sddm/sddm.conf.d/default.conf` <br/>

If you aren't using vanilla Arch Linux you'll have to change the last line to wherever the SDDM default.conf is located in your distro. <br/>
Some distro's may not even have this option specified thus you may have to create it instead.

