FROM debian:stretch

ARG BUILD_TOOLS="autoconf=2.69-10 \
  automake=1:1.15-6 \
  bzip2=1.0.6-8.1 \
  curl=7.52.1-5+deb9u10 \
  default-libmysqlclient-dev=1.0.2 \
  git=1:2.11.0-3+deb9u7 \
  gnupg=2.1.18-8~deb9u4 \
  libffi-dev=3.2.1-6 \
  libreadline-dev=7.0-3 \
  libssl-dev=1.1.0l-1~deb9u1 \
  libtool=2.4.6-2 \
  libxml2-dev=2.9.4+dfsg1-2.2+deb9u2 \
  libyaml-dev=0.1.7-2 \
  make=4.1-9.1 \
  unixodbc-dev=2.3.4-1 \
  unzip=6.0-21+deb9u2 \
  zlib1g-dev=1:1.2.8.dfsg-5"

RUN apt update \
  && apt install -y $BUILD_TOOLS \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m app

ENV BUNDLE_PATH="/usr/local/bundle"
RUN mkdir -p $BUNDLE_PATH \
  && chown -R app:app $BUNDLE_PATH

USER app:app
WORKDIR /home/app/src

ARG ASDF_VERSION=0.7.8
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v$ASDF_VERSION \
  && echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc \
  && echo '. $HOME/.asdf/asdf.sh' >> ~/.profile \
  && echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

SHELL ["/bin/bash", "-l", "-c"]

RUN asdf plugin add ruby \
  && asdf plugin add nodejs \
  && bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring \
  && asdf plugin add yarn

COPY --chown=app .tool-versions /home/app/
RUN asdf install

ENV BUNDLER_VERSION=2.1.4
RUN gem install bundler --version $BUNDLER_VERSION
RUN bundle config --global path $BUNDLE_PATH

COPY --chown=app . /home/app/src
RUN bundle install
