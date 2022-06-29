FROM code.pztrn.name/containers/mirror/alpine:3.16

# Install necessary things
RUN apk add --no-cache \
    git \
    nginx \
    php7-curl \
    php7-dom \
    php7-fpm \
    php7-iconv \
    php7-json \
    php7-openssl \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-xml \
    s6 \
    unzip \
    wget && \
    rm /etc/nginx/conf.d/default.conf && \
    rm /etc/php7/php-fpm.d/www.conf && \
    mkdir /var/run/nginx && \
    chown -R nginx:nginx /var/run/nginx 

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
