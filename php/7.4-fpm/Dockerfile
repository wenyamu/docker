FROM dockette/debian:bullseye-slim

LABEL maintainer="sulcmil@gmail.com"

# PHP
ENV PHP_MODS_DIR=/etc/php/7.4/mods-available
ENV PHP_FPM_DIR=/etc/php/7.4/fpm
ENV PHP_FPM_CONF_DIR=${PHP_FPM_DIR}/conf.d
ENV PHP_FPM_POOL_DIR=${PHP_FPM_DIR}/pool.d
ENV TZ=Europe/Prague

ARG USER_ID=82
ARG GROUP_ID=82

RUN usermod -u ${USER_ID} www-data && \
    groupmod -g ${GROUP_ID} www-data

# INSTALLATION
RUN apt update && apt dist-upgrade -y && \
    apt install -y --no-install-recommends \
        php7.4-apcu \
        php7.4-bz2 \
        php7.4-bcmath \
        php7.4-calendar \
        php7.4-ctype \
        php7.4-curl \
        php7.4-fpm \
        php7.4-geoip \
        php7.4-gettext \
        php7.4-gd \
        php7.4-intl \
        php7.4-imap \
        php7.4-ldap \
        php7.4-mbstring \
        php7.4-memcached \
        php7.4-mongodb \
        php7.4-mysql \
        php7.4-pdo \
        php7.4-pgsql \
        php7.4-redis \
        php7.4-soap \
        php7.4-sqlite3 \
        php7.4-zip \
        php7.4-xmlrpc \
        php7.4-xsl && \
    # PHP MOD(s) ###############################################################
    ln -s ${PHP_MODS_DIR}/custom.ini ${PHP_FPM_CONF_DIR}/999-custom.ini && \
    # CLEAN UP #################################################################
    rm -rf ${PHP_FPM_POOL_DIR}/www.conf && \
    rm -rf /etc/php/7.4/cli && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# FILES (it overrides originals)
ADD conf.d/custom.ini ${PHP_MODS_DIR}/custom.ini
ADD fpm/php-fpm.conf ${PHP_FPM_DIR}/php-fpm.conf

# WORKDIR
WORKDIR /srv

# COMMAND
CMD ["php-fpm7.4"]
