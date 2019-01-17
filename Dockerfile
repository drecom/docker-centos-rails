FROM drecom/centos-ruby:2.6.0
LABEL maintainer "Drecom Technical Development Department <pr_itn@drecom.co.jp>"

ENV RALS_VERSION 5.2.2

# Change default locale to ja-JP.UTF-8
ENV LANG=ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime \
&&  echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock

# Install Ruby on Rails
RUN gem install rails --version "$RAILS_VERSION"

# Install Node.js and Yarn
RUN yum -y install make gcc-c++ && \
    curl -sL https://rpm.nodesource.com/setup_11.x | bash - && \
    curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo && \
    yum -y install \
      nodejs \
      yarn

# Install packages
RUN yum install -y \
    readline-devel\
    wget \
    curl \
    dtach \
    vim \
    hash-slinger \
    bzip2 \
    tar \
    ImageMagick \
    ImageMagick-devel \
    libffi-devel \
    libxslt-devel \
    mysql

RUN yum clean all

CMD [ "irb" ]
