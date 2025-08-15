FROM selenium/node-chrome:latest@sha256:de55efe978f30e29d7962790e6bdc1dcc7d6bd6973b5a7d36229668f93b0abca

USER root

RUN apt-get update -qqy \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && rm /bin/sh && ln -s /bin/bash /bin/sh \
  && chown seluser /usr/local

ENV NVM_DIR /usr/local/nvm
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
  && source $NVM_DIR/nvm.sh \
  && nvm install v11

ENV CHROME_BIN /opt/google/chrome/chrome
ENV INSIDE_DOCKER=1

WORKDIR /usr/src
ENTRYPOINT source $NVM_DIR/nvm.sh && npm i && npm test
