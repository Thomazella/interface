#! /usr/bin/env bash

echo Some commands and instructions that may help restoring files saved here to a fresh system
echo "
  linux/etc/udev/hwdb.d/70-custom-keyboard.hwdb
    perms
    sudo chown root 70-custom-keyboard.hwdb
    sudo chgrp root 70-custom-keyboard.hwdb
    sudo chmod g+w,o+w 70-custom-keyboard.hwdb
    hardlink it
    sudo ln \${PWD}/linux/etc/udev/70-custom-keyboard.hwdb /etc/udev/hwdb.d/70-custom-keyboard.hwdb
    see this for editing the file
    https://gist.github.com/Thomazella/fcd1fac083a9c7f792c70fb49a71177c#gistcomment-3122968
"
# E: KEYBOARD_KEY_70039=leftmeta
# E: KEYBOARD_KEY_700e0=leftalt
# E: KEYBOARD_KEY_700e2=leftctrl
# E: KEYBOARD_KEY_700e3=leftmeta
# E: KEYBOARD_KEY_700e4=rightalt
# E: KEYBOARD_KEY_700e6=rightctrl
