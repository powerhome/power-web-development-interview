FROM debian:bookworm@sha256:bd73076dc2cd9c88f48b5b358328f24f2a4289811bd73787c031e20db9f97123

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
# REMOVE ME: Workaround for https://bugs.ruby-lang.org/issues/20085.
# The RUBY_APPLY_PATCHES var should be removed either when ruby is
# upgraded to a version >3.3.0 or a newer version of ruby-build is
# available to asdf-ruby which includes the backported patch to ruby
# 3.3.0.
RUN RUBY_APPLY_PATCHES="https://patch-diff.githubusercontent.com/raw/ruby/ruby/pull/9371.diff" asdf install

ENV BUNDLER_VERSION=2.4.10
RUN gem install bundler --version $BUNDLER_VERSION
RUN bundle config --global path $BUNDLE_PATH

COPY --chown=app . /home/app/src
RUN bundle install
