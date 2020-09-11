ARG Distro=ubuntu

FROM ${Distro}
LABEL Author Ronald Baltus <ronaldbaltus@gmail.com>

ARG WindowManager=openbox
ARG Username=someuser

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y supervisor openssh-server sudo
RUN apt-get install -y ${WindowManager} 
#RUN apt-get install -y mate-core mate-desktop-environment mate-notification-daemon firefox
#RUN apt-get install -y snap snapd

# Remote access
RUN apt-get install -y xrdp 
RUN adduser xrdp ssl-cert  
# Update xrdp
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini && \
    xrdp-keygen xrdp auto
ADD xrdp.conf /etc/supervisor/conf.d/xrdp.conf
# End remote access

# Tools
RUN apt-get update && apt-get install -y xterm tmux firefox

# Add desktop user
RUN useradd -ms /bin/bash ${Username}
RUN echo ${Username}:${Username} | chpasswd
RUN echo root:${Username} | chpasswd
RUN echo "${WindowManager}-session" > /home/${Username}/.xsession
# End

#CMD /etc/xrdp/startwm.sh
CMD ["/usr/bin/supervisord", "-n"]

EXPOSE 3389 22