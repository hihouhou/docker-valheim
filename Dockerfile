#
# Valheim server Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV VALHEIM_VERSION=1.0.14

# Update & install packages for grafana
RUN apt-get update && \
    apt-get install -y curl wget file tar bzip2 gzip unzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat-traditional lib32gcc-s1 lib32stdc++6 libsdl2-2.0-0

RUN useradd -ms /bin/bash valheim

USER valheim

RUN mkdir -p /home/valheim/steam/valheim && \
    usermod -u 1000 valheim

#Get steamcmd
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz -O /tmp/steamcmd_linux.tar.gz && \
    cd /tmp && \
    tar xf steamcmd_linux.tar.gz && \
    chmod +x steamcmd.sh && \
    ./steamcmd.sh +login anonymous +force_install_dir /home/valheim/steam/valheim +app_update 896660 validate +exit

WORKDIR /home/valheim/steam/valheim

#CMD /bin/bash start_server.sh -nographics -batchmode -name $SERVER_NAME -port $SERVER_PORT -world $WORLD_NAME -password $SERVER_PASS -public $SERVER_PUBLIC
CMD ["/bin/bash", "start_server.sh", "-nographics", "-batchmode", "-name", "$SERVER_NAME", "-port", "$SERVER_PORT", "-world", "$WORLD_NAME", "-password", "$SERVER_PASS", "-public", "$SERVER_PUBLIC"]
