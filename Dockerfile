FROM code.pztrn.name/containers/mirror/alpine:3.16.0

# Install necessary things
RUN apk add --no-cache \
    git \
    nginx \
    php8-curl \
    php8-dom \
    php8-fpm \
    php8-iconv \
    php8-json \
    php8-openssl \
    php8-pdo_mysql \
    php8-pdo_pgsql \
    php8-pdo_sqlite \
    php8-xml \
    s6 \
    unzip \
    wget && \
    rm /etc/php8/php-fpm.d/www.conf

# Get rainloop.
RUN mkdir -p /var/www/rainloop && \
    cd /var/www/rainloop && \
    wget https://github.com/RainLoop/rainloop-webmail/releases/download/v1.16.0/rainloop-community-1.16.0.zip && \
    ls -la && \
    unzip rainloop-community-*.zip && \
    chown -R nginx:nginx /var/www/rainloop && \
    rm *.zip

# Configure container
COPY configs/ /etc/

# Configure s6.
RUN chmod -R +x /etc/s6/* \
    && chmod +x /etc/s6/.s6-svscan/finish

EXPOSE 80

VOLUME [ "/var/www/rainloop/data" ]

ENTRYPOINT ["/bin/s6-svscan", "/etc/s6"]
