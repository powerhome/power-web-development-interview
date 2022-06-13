FROM debian:buster

ARG BUILD_TOOLS="\
  autoconf=2.69-11 \
  automake=1:1.16.1-4 \
  bzip2=1.0.6-9.2~deb10u1 \
  curl=7.64.0-4+deb10u2 \
  default-libmysqlclient-dev=1.0.5 \
  git=1:2.20.1-2+deb10u3 \
  gnupg=2.2.12-1+deb10u1 \
  libffi-dev=3.2.1-9 \
  libreadline-dev=7.0-5 \
  libssl-dev=1.1.1n-0+deb10u2 \
  libtool=2.4.6-9 \
  libxml2-dev=2.9.4+dfsg1-7+deb10u4 \
  libyaml-dev=0.2.1-1 \
  make=4.2.1-1.2 \
  unixodbc-dev=2.3.6-0.1 \
  unzip=6.0-23+deb10u2 \
  zlib1g-dev=1:1.2.11.dfsg-1+deb10u1 \
  "

RUN apt-get update \
  && apt-get install -y $BUILD_TOOLS \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m app

ENV BUNDLE_PATH="/usr/local/bundle"
RUN mkdir -p $BUNDLE_PATH \
  && chown -R app:app $BUNDLE_PATH

USER app:app
WORKDIR /home/app/src

ARG ASDF_VERSION=0.8.0
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v$ASDF_VERSION \
  && echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc \
  && echo '. $HOME/.asdf/asdf.sh' >> ~/.profile \
  && echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

SHELL ["/bin/bash", "-l", "-c"]

RUN asdf plugin add ruby \
  && asdf plugin add nodejs \
  && asdf plugin add yarn

COPY --chown=app .tool-versions /home/app/
RUN asdf install

ENV BUNDLER_VERSION=2.1.4
RUN gem install bundler --version $BUNDLER_VERSION
RUN bundle config --global path $BUNDLE_PATH

COPY --chown=app . /home/app/src
RUN bundle install
