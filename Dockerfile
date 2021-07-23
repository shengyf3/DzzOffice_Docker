FROM php:7.3.8-apache-stretch

ENV VERSION 2.02

RUN apt-get update && apt-get install -y libzip-dev libfreetype6-dev \
  && docker-php-ext-install mysqli \
  && docker-php-ext-install gd \
  && docker-php-ext-install zip

RUN curl -o /tmp/dzzoffice-2.02.1.tar.gz https://codeload.github.com/zyx0814/dzzoffice/tar.gz/2.02.1 \
  && tar -xzvf /tmp/dzzoffice-2.02.1.tar.gz -C /tmp \
  && rm -rf /tmp/dzzoffice-2.02.1.tar.gz /tmp/dzzoffice-2.02.1/*.md \
  && mv /tmp/dzzoffice-2.02.1/* /var/www/html/

RUN chown -R www-data:www-data /var/www/html/