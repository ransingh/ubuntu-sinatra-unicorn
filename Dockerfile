# DOCKER-VERSION 1.6.2

FROM ubuntu:14.04

MAINTAINER Ranbir Singh "ransingh57@yahoo.com"

RUN apt-get -y update

# install essentials
RUN apt-get -y install build-essential curl
RUN apt-get install -y -q git
RUN apt-get install -y --force-yes zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt-dev \
    libpq-dev

# Install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh

# install ruby-build
RUN mkdir /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

ENV RBENV_ROOT /usr/local/rbenv

ENV PATH "$RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# does not work. PATH is set to
# $RBENV_ROOT/shims:$RBENV_ROOT/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# install ruby2
RUN rbenv install 2.3.0

# set ruby 2.2.0 as system ruby
RUN ["rbenv","global","2.3.0"]

# install Unicorn as app server
RUN ["gem", "install", "unicorn"]

# install bundler
RUN ["gem", "install", "bundler"]
