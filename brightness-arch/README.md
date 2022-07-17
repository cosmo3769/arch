I ran into an issue upon a fresh installation of i3wm on my laptop where, for whatever reason, my XF86MonBrightnessUp/Down keys weren't being 
registered (I checked with xev). What I ended up doing is creating acpi actions and events which corresponded to the keys being pressed.

The following are the actions/events I defined in /etc/acpi/actions and /etc/acpi/events, respectively:

## install acpi

`sudo pacman -S acpid`

## acpi event code for brightness keys

`acpi-listen` - to see the acpi event codes by pressing the particular keys. (in my case: brightness-up-F4, brightness-down=F3) 

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

## Execute Actions scripts 

`sudo chmod +x /etc/acpi/actions/bl-down.sh`

`sudo chmod +x /etc/acpi/actions/bl-up.sh`

## Reload acpid 

I was going through one reference to how to set actions and events where the way to reload the acpid
was not working for me. So I did it this way.

`sudo systemctl restart acpid.service`

`sudo systemctl restart acpid`

& voila my brightness keybinds works now. 

Before leaving one thing you shoulf note that I have still not enabled the acpid service. I have just 
started the service which will be disabled after reboot or poweroff of the system. So to keep it 
enabled, run: 

`sudo systemctl enable acpid.service`

`sudo systemctl start acpid.service`

You can check the status of the service being started or not with: 

`sudo systemctl status acpid.service`
