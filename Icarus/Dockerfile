FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    unzip \
    wine64 \
    wine32 \
    xvfb \
    lib32gcc-s1 \
    lib32stdc++6 \
  && rm -rf /var/lib/apt/lists/*

# Install steamcmd
RUN mkdir -p /opt/steamcmd \
  && cd /opt/steamcmd \
  && wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz

WORKDIR /opt/icarus

COPY entrypoint.sh /usr/local/bin/icarus-entrypoint.sh
RUN chmod +x /usr/local/bin/icarus-entrypoint.sh

EXPOSE 17777/tcp 17777/udp 27015/udp 15000/udp

ENTRYPOINT ["/usr/local/bin/icarus-entrypoint.sh"]
