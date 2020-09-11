# Docker Linux Desktop
Docker linux desktop is a way to easily deploy a linux desktop environment into docker. This image uses RDP to make the desktop available to the user. Currently openbox is installed on top of ubuntu as a default and I will add other windowmanagers in the future as well. 

## How to run
With docker-compose:

Openbox: `docker-compose up LinuxDesktopOpenbox`
Xfce: `docker-compose up LinuxDesktopXfce`
Mate: `docker-compose up LinuxDesktopMate`

Run directly with docker (default is openbox):
`docker run -p 3389:3389 -e Username=myuser ronaldbaltus/docker-linux-desktop`

## Username and password
The current username and password are `someuser` and `someuser`. You can use the Username environment variable to change the username,the password will match the username.
