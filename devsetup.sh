#!/bin/bash

# devstartup - set up of configs on starup that make development easier on chrome os

# Requirements: chromium OS universal chroot : https://github.com/dnschneid/crouton

# Run this script on a Chromebook:
# 1. Put Chromebook in developer mode - https://www.chromium.org/chromium-os/poking-around-your-chrome-os-device
# 2. Log into device. Press CTRL+ALT+T to open crosh shell.
# 3. Type "shell" to enter Bash shell.
# 4. Type:
#      bash <(curl -s -S -L https://raw.githubusercontent.com/cat-turner/chromeos-dev/master/devstartup.sh)

cat >/tmp/devstartup.conf <<EOL
description  "set up to make my development easier on chrome os"
author       "turner.cathleen@gmail.com"

start on runlevel [2345]
stop on shutdown
respawn
# respawn the job up to 10 times within a 5 second period.
respawn limit 10 5

pre-start script
  echo "[`date`] devsetup - Setting up..."
end script

post-stop script
  echo "[`date`] devsetup - Stopping..."
end script

script

    export CHROOTSLINK="/mnt/stateful_partition/crouton/chroots"
    ln -s "$CHROOTSLINK/trusty/home/mumu/Downloads" "/home/chronos/user/Downloads/Downloads"

end script

EOL
sudo mv /tmp/devstartup.conf /etc/init/
sudo chmod 644 /etc/init/devstartup.conf
sudo chown root.root /etc/init/devstartup.conf
echo

echo "devsetup done..."
