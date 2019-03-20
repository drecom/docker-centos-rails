FROM drecom/centos-ruby:2.5.5-slim
LABEL maintainer "Drecom Technical Development Department <pr_itn@drecom.co.jp>"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Change default locale to ja-JP.UTF-8
ENV LANG=ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime && \
    echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock

# Add repository
RUN curl -sL https://rpm.nodesource.com/setup_11.x | bash - && \
    curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo && \
    yum -y install epel-release

# Install packages
RUN yum -y  groupinstall "Development Tools" && \
    yum -y install \
        gcc \
        nodejs \
        yarn  \
        wget \
        mysql \
        redis \
        readline-devel \
        libffi-devel \
        libxslt-devel \
        zlib-devel \
        openssl-devel \
        mysql-devel \
        sqlite-devel && \
    yum clean all

CMD [ "irb" ]
