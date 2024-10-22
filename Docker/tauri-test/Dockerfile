# FROM ubuntu:24.04
FROM rust:1.82.0-bookworm

# RUN apt update && apt install -y curl git
# dependencies of Tauri
RUN apt update && apt install -y libwebkit2gtk-4.1-dev \
    libxdo-dev \
    libssl-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev

ARG LOCALUID
ARG LOCALGID
ARG LOCALUNAME

RUN groupadd -g ${LOCALGID} {LOCALUNAME} && \
useradd -m -u ${LOCALUID} -g ${LOCALGID} -G sudo ${LOCALUNAME}

USER ${LOCALUNAME}
WORKDIR /home/${LOCALUNAME}

# USER ubuntu
# WORKDIR /home/ubuntu

SHELL ["/bin/bash", "-c"]

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# LTS版のnodeをインストール
RUN . $HOME/.nvm/nvm.sh && \
    nvm install --lts && \
    nvm use --lts && \
    node -v && npm -v && \
    npm i -g yarn

COPY Docker/tauri-test/addpath /home/${LOCALUNAME}/
RUN cat /home/${LOCALUNAME}/addpath >> $HOME/.bashrc


CMD ['/bin/bash']
