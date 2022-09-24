# Setting up bluetooth in arch 

## Install bluez bluez-utils 

sudo pacman -S bluez bluez-utils

bluetoothctl

power on 

agent on 

default agent 

scan on 

pair <MAC Address>

connect <MAC Address>
  
[Reference](https://www.youtube.com/watch?v=rOL-T31l0lQ)

## Problem faced
  
First: connection failed: br-connection-profile-unavailable
  
Soution: install pulseaudio, pulseaudio-bluetooth(sudo pacman -S pulseaudio pulseaudio-bluetooth), run `pulseaudio -k`, `pulseaudio --start` 
  
Problem solved! (bluez only supports pulseaudio, and not alsa)

[Reference](https://www.youtube.com/watch?v=NDhUg9mNHyA)
  
Second: cannot connect to audio over bluetooth
  
Soution: install pavucontrol(sudo pacman -S pavucontrol)
  
Third: running pavucontrol(gives: Establishing connection to pulseaudio, please wait) 
  
Solution: run `pulseaudio -k`, `pulseaudio --start`, `pulseaudio -D`

[Reference](https://www.youtube.com/watch?v=I7WqCgjjqJ0&t=84s)

Problem Solved!
  
## References
  
[Reference](https://www.jeremymorgan.com/tutorials/linux/how-to-bluetooth-arch-linux/)
  
[Reference](https://linuxhint.com/configure_bluetooth_arch_linux/)
