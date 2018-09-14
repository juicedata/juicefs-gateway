FROM debian:buster
ARG DEBMIRROR=deb.debian.org

COPY start.sh /root
RUN sed -i "s/deb.debian.org/$DEBMIRROR/g" /etc/apt/sources.list && \
  sed -i "s/security.debian.org/$DEBMIRROR/g" /etc/apt/sources.list && \
  apt-get update && \
  apt-get install --no-install-recommends -y curl locales nfs-ganesha nfs-ganesha-vfs samba netatalk python python-pip fuse busybox-syslogd && \
  echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && \
  locale-gen && \
  apt-get clean -y && \
  apt-get autoclean -y && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/* /var/cache/*
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
EXPOSE 2049 137/udp 138/udp 139 445
CMD /root/start.sh
