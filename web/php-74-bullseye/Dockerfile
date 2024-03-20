FROM dockette/debian:bullseye-slim

# TENGINE/NGINX
ENV TENGINE_VERSION 3.1.0

# PHP-FPM
ENV PHP_FPM_BIN=/usr/sbin/php-fpm7.4
ENV PHP_FPM_CONF=/etc/php/7.4/php-fpm.conf

ENV TZ=Europe/Prague

ENV CONFIG "\
    --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx \
    --modules-path=/usr/lib/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --user=www-data \
    --group=www-data \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_stub_status_module \
    --with-http_auth_request_module \
    --with-threads \
    --with-stream \
    --with-stream_ssl_module \
    --with-stream_ssl_preread_module \
    --with-stream_realip_module \
    --with-http_slice_module \
    --with-mail \
    --with-mail_ssl_module \
    --with-compat \
    --with-file-aio \
    --with-http_v2_module \
    --with-ipv6 \
    --with-http_image_filter_module=dynamic \
    --with-http_geoip_module=dynamic \
    --with-stream_geoip_module=dynamic \
    --add-module=modules/ngx_http_upstream_check_module \
    --add-module=modules/ngx_http_concat_module \
    --add-module=modules/dynamic-upstream-module-src-0.1.6 \
    --add-module=modules/ngx_http_upstream_session_sticky_module \
    "

RUN usermod -u 82 www-data \
    && groupmod -g 82 www-data \
    && apt update -y \
    && apt install -y --no-install-recommends \
        gcc \
        make \
        libc-dev \
        openssl \
        libssl-dev \
        libpcre3-dev \
        zlib1g-dev \
        libgd-dev \
        libgeoip-dev \
        curl \
        ca-certificates \
    && curl -L "https://github.com/alibaba/tengine/archive/$TENGINE_VERSION.tar.gz" -o tengine.tar.gz \
    && mkdir -p /var/cache/nginx/client_temp \
    && mkdir -p /usr/src \
    && tar -zxC /usr/src -f tengine.tar.gz \
    && rm tengine.tar.gz \
    && cd /usr/src/tengine-$TENGINE_VERSION \
    && curl -L "https://github.com/nginx-with-docker/dynamic-upstream-module-src/archive/refs/tags/v0.1.6.tar.gz" -o more.tar.gz \
    && tar -zxC /usr/src/tengine-$TENGINE_VERSION/modules -f more.tar.gz \
    && rm more.tar.gz \
    && ./configure $CONFIG \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && rm -rf /etc/nginx/html/ \
    && mkdir -p /etc/nginx/conf.d/ \
    && ln -s /usr/lib/nginx/modules /etc/nginx/modules \
    && strip /usr/sbin/nginx* \
    && strip /usr/lib/nginx/modules/*.so \
    && rm -rf /usr/src/tengine-$TENGINE_VERSION \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# PHP
RUN apt install -y --no-install-recommends \
        cron \
        supervisor \
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
        php7.4-ssh2 \
        php7.4-tidy \
        php7.4-zip \
        php7.4-xmlrpc \
        php7.4-xsl && \
    # PHP MOD(s) ###############################################################
    rm -rf /etc/php/7.4/cli && \
    # CLEAN UP #################################################################
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get remove -y gcc make curl ca-certificates && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

# CRON
RUN truncate -s 0 /etc/crontab

# PHP
ADD ./php/php-fpm.conf /etc/php/7.4/
ADD ./php/php.ini /etc/php/7.4/conf.d/

# NGINX
ADD ./nginx/nginx.conf /etc/nginx/
ADD ./nginx/mime.types /etc/nginx/
ADD ./nginx/sites.d /etc/nginx/sites.d

# WWW
ADD ./www /srv/www/

# SUPERVISOR
ADD ./supervisor/supervisord.conf /etc/supervisor/
ADD ./supervisor/services /etc/supervisor/conf.d/

# APPLICATION
WORKDIR /srv

# PORTS
EXPOSE 80 443

COPY entrypoint.sh /usr/sbin/entrypoint.sh
RUN chmod +x /usr/sbin/entrypoint.sh
CMD ["/usr/sbin/entrypoint.sh"]
