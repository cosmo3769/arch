In i3 config file I was using bindsym for XF86MonBrightnessUp/Down keys to control brightness with 
function keys. But, it never worked. So, while looking for an answer I found this [reference](https://unix.stackexchange.com/questions/322814/xf86monbrightnessup-xf86monbrightnessdown-special-keys-not-working/427572#427572) where actions/events were created using acpid service.

This was the bindsym I was using with xbacklight in i3 config: 

```
# Use xbacklight to control brightness with keyboard
bindsym XF86MonBrightnessUp exec xbacklight -inc 5000
bindsym XF86MonBrightnessDown exec xbacklight -dec 5000
```

When this was not working and I couldn't find the solution to keybind my brightness keys, I was manually increasing and decreasing my brightness from the terminal, either with updating the values of `/sys/class/backlight/intel-backlight/brightness` or running this command `xbacklight -inc 2000` to increase the brightness and `xbacklight -dec 2000` to decrease the brightness.

So, finally I made it easier using acpi events. The following are the actions/events I defined in /etc/acpi/actions and /etc/acpi/events, respectively:

## Install acpid

`sudo pacman -S acpid`

## acpi event code for brightness keys

`acpi-listen` - to see the acpi event codes by pressing the particular keys. (in my case: brightness-up=F4, brightness-down=F3) 

Running this gave me this error `acpi_listen: can't open socket /var/run/acpid.socket: No such file or directory`

It occured because I have not started the acpid service. I started this with `sudo systemctl start acpid.service`.

Now I can listen to the acpi event code in the terminal when I press the particular keys.

## Setting Actions 

Make this file `/etc/acpi/actions/bl-down.sh` for brightness down action to be triggered.

Update the file with: 

```
#!/bin/sh

bl_device=/sys/class/backlight/intel-backlight/brightness
echo $(($(cat $bl_device)-2000)) | sudo tee $bl_device
```

Make this fie `/etc/acpi/actions/bl-up.sh` for brightness up action to be triggered. 

Update the file with: 

```
#!/bin/sh

bl_device=/sys/class/backlight/intel-backlight/brightness
echo $(($(cat $bl_device)+2000)) | sudo tee $bl_device
```

**NOTE-** You will find your **bl_device** by checking in your system with `ls /sys/class/backlight/`. After this it can be intel_backlight or acpi_video0 or something else in your system. Ensure to inlcude the one showing in your system. 

## Setting Events

Make this file `/etc/acpi/events/bl-down` for triggering brightness down events.

Update this file with: 

```
event=video/brightnessdown BRTDN 00000087 00000000
action=/etc/acpi/actions/bl-down.sh
```

Make this file `/etc/acpi/events/bl-up` for triggering brightness up events.

Update this file with: 

```
event=video/brightnessup BRTUP 00000086 00000000
action=/etc/acpi/actions/bl-up.sh
```

**NOTE-** You will find your acpi event code by running acpi_listen and pressing on brightness up/down keys. Copy your acpi event code in **event**.

## Execute Actions scripts 

`sudo chmod +x /etc/acpi/actions/bl-down.sh`

`sudo chmod +x /etc/acpi/actions/bl-up.sh`

## Reload acpid 

When going through the above reference of how to set actions and events, the way to reload the acpid
is different in my case. I have systemctl to interact with any services in my machine, so here is how it works: 

`sudo systemctl restart acpid.service`

& voila my brightness keybinds works now. 

## Enable acpid service

Before leaving one thing you should note that I have still not enabled the acpid service. I have just 
started the service which will be disabled after reboot or poweroff of the system. So to keep it 
enabled, run: 

`sudo systemctl enable acpid.service`

`sudo systemctl start acpid.service`

You can check the status of the service being started or not with: 

`sudo systemctl status acpid.service`
