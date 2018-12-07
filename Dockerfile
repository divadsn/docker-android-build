FROM ubuntu:18.04
MAINTAINER David Sn <divad.nnamtdeis@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV USER jenkins
ENV HOSTNAME buildbot
ENV USE_CCACHE 1
ENV CCACHE_DIR /tmp/ccache

# Install required dependencies 
RUN apt-get update && \
    apt-get install -y \
        bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-core gnupg gperf imagemagick openjdk-8-jre openjdk-8-jdk \
        lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libc6-dev libc6-dev-i386 libgl1-mesa-dev \
        libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip unzip zlib1g-dev libx11-dev x11proto-core-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install repo binary (thanks akheel)
RUN curl --create-dirs -L -o /usr/local/bin/repo -O -L https://github.com/akhilnarang/repo/raw/master/repo && \
    chmod a+x /usr/local/bin/repo

# Create seperate user for building
RUN groupadd -g 1000 -r ${USER} && \
    useradd -u 1000 --create-home -r -g ${USER} ${USER} && \
    mkdir -p /tmp/ccache /repo && \
    chown -R ${USER}: /tmp/ccache /repo

# Setup volumes for persistent data
USER ${USER}
VOLUME ["/tmp/ccache", "/repo"]

# Work in the build directory, repo is expected to be init'd here
WORKDIR /repo

# This is where the magic happens~
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]