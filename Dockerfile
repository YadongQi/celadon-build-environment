FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk git ccache automake \
       lzop bison gperf build-essential zip curl \
       zlib1g-dev g++-multilib python3-networkx \
       libxml2-utils bzip2 libbz2-dev libbz2-1.0 \
       libghc-bzlib-dev squashfs-tools pngcrush \
       schedtool dpkg-dev liblz4-tool make optipng maven \
       libssl-dev bc bsdmainutils gettext python3-mako \
       libelf-dev sbsigntool dosfstools mtools efitools \
       python3-pystache git-lfs python3 flex clang libncurses5 \
       fakeroot ncurses-dev xz-utils cryptsetup-bin \
       apt-transport-https ca-certificates curl lsb-release \
       rsync python-pystache python-mako vim python-six

RUN apt-get install -y software-properties-common

#install the Docker Engine - Community from the repository:
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -  &&\
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

RUN  apt-get update &&\
     apt-get install -y docker-ce docker-ce-cli containerd.io

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get update && \
    apt-get -y install git-lfs

RUN apt-get install -y cpio

#creating user celadonuser
ENV CUSER celadon
ENV CUSERHOME /home/$CUSER
ENV CGRP celadon


RUN groupadd -g 9999 $CGRP && \
useradd -m -d $CUSERHOME -g $CGRP  $CUSER

ADD ./.gitconfig ${CUSERHOME}

USER $CUSER
WORKDIR  /home/$CUSER


#google repo installation steps

RUN mkdir -p ${CUSERHOME}/.bin
ENV PATH ${CUSERHOME}/.bin:${PATH}
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ${CUSERHOME}/.bin/repo
RUN chmod a+rx ${CUSERHOME}/.bin/repo