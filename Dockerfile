# FROM php:8.1-fpm-alpine
FROM php:8.2-cli-alpine
# ARG SHOPIFY_API_KEY
# FROM php:8.2-fpm-alpine
ENV SHOPIFY_API_KEY=f052d4d4c71501ef067a4c0fe79360f1

RUN apk update && apk add --update nodejs npm \
    composer php-pdo_sqlite php-pdo_mysql php-pdo_pgsql php-simplexml php-fileinfo php-dom php-tokenizer php-xml php-xmlwriter php-session \
    openrc bash nginx

# RUN apk add --no-cache php-fpm

RUN docker-php-ext-install pdo

COPY web /app
WORKDIR /app

# Overwrite default nginx config
# COPY web/nginx.conf /etc/nginx/nginx.conf

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN composer install
RUN touch /app/storage/db.sqlite
# RUN chown www-data:www-data /app/storage/db.sqlite

RUN cd frontend && npm install && npm run build
 
RUN composer build
# EXPOSE 80
EXPOSE 9000
EXPOSE 8000
# RUN chmod +x /app/entrypoint.sh
# ENTRYPOINT [ "/app/entrypoint.sh" ]
# RUN sed -i 's/hostname $opts/# hostname 127.0.0.1/g' /etc/init.d/hostname && \
#     sed -i 's/#rc_sys=""/rc_sys="docker"/g' /etc/rc.conf && \
#     sed -i "s/listen PORT/listen 9000/g" /etc/nginx/nginx.conf

# Run database migrations
RUN echo "Running database migrations..." && \
    php artisan migrate --force

# Start nginx server
# RUN echo "Starting nginx server..." && \
#     openrc && \
#     touch /run/openrc/softlevel && \
#     rc-service nginx start

# # Start PHP server
# CMD ["php-fpm"]