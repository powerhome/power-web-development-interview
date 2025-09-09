FROM debian:trixie@sha256:833c135acfe9521d7a0035a296076f98c182c542a2b6b5a0fd7063d355d696be

ARG BUILD_TOOLS="\
  autoconf \
  automake \
  bzip2 \
  build-essential \
  curl \
  default-libmysqlclient-dev \
  g++ \
  git \
  gnupg \
  libffi-dev \
  libreadline-dev \
  libssl-dev \
  libtool \
  libxml2-dev \
  libyaml-dev \
  make \
  unixodbc-dev \
  unzip \
  zlib1g-dev \
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

ENV BUNDLER_VERSION=2.4.10
RUN gem install bundler --version $BUNDLER_VERSION
RUN bundle config --global path $BUNDLE_PATH

COPY --chown=app . /home/app/src
RUN bundle install
