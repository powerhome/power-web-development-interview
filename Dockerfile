FROM ruby:2.5.1-stretch

ARG DISTRO_NAME=debian
ARG DISTRO_RELEASE_CODENAME=stretch
ARG NODE_VERSION=node_8.x

RUN apt-get update -qq \
  && apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    wget \
  && wget -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
  && echo "deb https://deb.nodesource.com/$NODE_VERSION $DISTRO_RELEASE_CODENAME main" >> /etc/apt/sources.list.d/nodesource.list \
  && echo "deb-src https://deb.nodesource.com/$NODE_VERSION $DISTRO_RELEASE_CODENAME main" >> /etc/apt/sources.list.d/nodesource.list \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/$DISTRO_NAME/ stable main" >> /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y \
     nodejs \
     yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists

RUN mkdir /opt/app
WORKDIR /opt/app
ENV BUNDLE_PATH /var/bundle

COPY ./Gemfile* /opt/app/
RUN bundle check || bundle install
ADD . /opt/app/
