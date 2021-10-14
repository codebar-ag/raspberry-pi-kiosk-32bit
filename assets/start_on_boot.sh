# /bin/bash

# Add start_on_boot.sh file to: /etc/xdg/lxsession/LXDE-pi/autostart
# with: @/bin/bash /PATH/TO/FILE/assets/start_on_boot.sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

cd $SCRIPTPATH
cd ..
cd autostart

/usr/bin/python3 autostart.py &