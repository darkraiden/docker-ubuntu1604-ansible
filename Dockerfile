FROM ubuntu:16.04
LABEL Author="Davide Di Mauro"

ENV RUBY_VERSION 2.2
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
                          ca-certificates \
                          openssl \
                          libssl-dev \
                          g++ \
                          gcc \
                          libc6-dev \
                          make \
                          patch \
                          sudo &&\
    rm -Rf /var/lib/apt/lists/* &&\
    rm -Rf /usr/share/doc &&\
    rm -Rf /usr/share/man &&\
    apt-get clean

# Install ruby
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C3173AA6 &&\
    echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu xenial main > /etc/apt/sources.list.d/brightbox-ruby-ng-trusty.list &&\
    apt-get update -q &&\
    apt-get install -yq --no-install-recommends \
                        ruby$RUBY_VERSION \
                        ruby$RUBY_VERSION-dev && \
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
