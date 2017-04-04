FROM ubuntu:16.04
MAINTAINER Davide Di Mauro

ENV RUBY_VERSION 2.3
ENV RUBYGEMS_VERSION 2.6.11
ENV BUNDLER_VERSION 1.14.6

# Install dependencies.
RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
                          python-software-properties \
                          software-properties-common \
                          libgdbm-dev \
                          systemd \
                          systemd-cron \
                          apt-utils \
                          sudo &&\
    rm -Rf /var/lib/apt/lists/* &&\
    rm -Rf /usr/share/doc &&\
    rm -Rf /usr/share/man &&\
    apt-get clean

# Install ruby
RUN apt-get update &&\
    apt-get install -y ruby$RUBY_VERSION &&\
    gem update --system "$RUBYGEMS_VERSION" &&\
    rm -Rf /var/lib/apt/lists/* &&\
    rm -Rf /usr/share/doc &&\
    rm -Rf /usr/share/man &&\
    apt-get clean

# Install bundler gem
RUN gem install bundler --version "$BUNDLER_VERSION"

# Install serverspec
RUN gem install serverspec

# Install Ansible
RUN add-apt-repository -y ppa:ansible/ansible &&\
    apt-get update &&\
    apt-get install -y --no-install-recommends \
                       ansible &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -Rf /usr/share/doc && rm -Rf /usr/share/man &&\
    apt-get clean

# Install Ansible inventory file
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts
