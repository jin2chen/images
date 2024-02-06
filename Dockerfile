ARG VERSION=8.3
ARG NODE_VERSION=20
FROM php:${VERSION}-fpm
ENV NVM_DIR="/root/.nvm"
RUN apt update \
    && apt install -y --no-install-recommends \
        default-mysql-client \
        net-tools \
        supervisor \
        dnsutils \
        iputils-ping \
        vim \
        telnet \
    && curl -fsSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions -o - | sh -s \
        mcrypt \
        yaml \
        opcache \
        xdebug \
        pdo_mysql \
        pdo_pgsql \
        ldap \
        bcmath \
        gmp \
        intl \
        pcntl \
        zip \
        unzip \
        amqp \
        apcu \
        tree \
    && cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini \
    && curl -fsSL -o /usr/local/bin/composer https://getcomposer.org/download/latest-2.x/composer.phar \
    && chmod +x /usr/local/bin/composer \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    && \. "$NVM_DIR/nvm.sh" && nvm install "$NODE_VERSION" \
    && sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc \
    && sed -i "/# some more ls aliases/aalias ll='ls -lh'\nalias la='ls -A'\nalias l='ls -CF'" /etc/skel/.bashrc \
    && cp -f /etc/skel/.bashrc /root/.bashrc \
    && useradd -m -s /bin/bash -u 1000 jin \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
