# Docker Linux Desktop
Docker linux desktop is a way to easily deploy a linux desktop environment into docker. This image uses RDP to make the desktop available to the user. Currently openbox is installed on top of ubuntu as a default and I will add other windowmanagers in the future as well. 

## How to run
With docker-compose:
`docker-compose up`

Run directly with docker:
`docker run -p 3389:3389 ronaldbaltus/docker-linux-desktop`

## Username and password
The current username and password are `someuser` and `someuser`. You are free to modify this through the build args.
