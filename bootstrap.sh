#!/bin/bash
# Starting dbus
service dbus start

# Add desktop user
echo "Provisioning user ${Username}"
useradd -ms /bin/bash ${Username}
usermod -aG sudo ${Username}
echo ${Username}:${Username} | chpasswd
echo root:${Username} | chpasswd

if [ "$WindowManager" = "xfce" ]
then
    echo "xfce4-session" > /home/${Username}/.xsession
else
    echo "${WindowManager}-session" > /home/${Username}/.xsession
fi

/usr/bin/supervisord -n