ARG Distro=ubuntu

FROM ${Distro}
LABEL Author Ronald Baltus <ronaldbaltus@gmail.com>

ARG WindowManager=openbox
ENV Username=someuser
ENV WindowManager=$WindowManager

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y supervisor openssh-server sudo

# Remote access
RUN apt-get install -y xrdp 
RUN adduser xrdp ssl-cert  
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto
ADD xrdp.conf /etc/supervisor/conf.d/xrdp.conf
# End remote access

# Window manager
RUN if [ "$WindowManager" = "openbox" ]; then apt-get install -y openbox; fi
RUN if [ "$WindowManager" = "mate" ]; then apt-get install -y --no-install-recommends ubuntu-mate-desktop; fi
RUN if [ "$WindowManager" = "gnome" ]; then apt-get install -y --no-install-recommends ubuntu-desktop dbus-x11; fi
RUN if [ "$WindowManager" = "lxde" ]; then apt-get install -y --no-install-recommends lubuntu-desktop; fi
RUN if [ "$WindowManager" = "xfce" ]; then apt-get install -y --no-install-recommends xubuntu-desktop dbus-x11; fi
RUN if [ "$WindowManager" = "enlightment" ]; then add-apt-repository ppa:niko2040/e19 && apt-get update && apt-get install -y libefl-dev; fi
# Window manager

# Tools
RUN apt-get update && apt-get install -y xterm tmux firefox

ADD bootstrap.sh /
CMD /bootstrap.sh

EXPOSE 3389 22