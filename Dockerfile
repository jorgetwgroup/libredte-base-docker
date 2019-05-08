FROM php:7.1-apache

RUN apt-get update \
    && apt-get install -y \
    	git  mercurial curl  wget memcached mcrypt \
		libcurl4-gnutls-dev libpng-dev libjpeg-dev zip \
		libssl-dev libc-client-dev libkrb5-dev libpq-dev \
		libghc-postgresql-libpq-dev libxml2-dev libmcrypt-dev \
		zlib1g-dev \

	&& pear install Mail Mail_mime Net_SMTP \

	&& docker-php-ext-configure gd --with-jpeg-dir=/usr/lib \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
	&& docker-php-ext-install -j$(nproc) imap \
	&& docker-php-ext-configure pgsql -with-pgsql=/usr/include/postgresql \
	&& docker-php-ext-install -j$(nproc) pgsql \
	&& docker-php-ext-install -j$(nproc) pdo pdo_pgsql mcrypt curl soap zip \
	&& pear install Mail Mail_mime Net_SMTP \
	&& a2enmod rewrite ssl php7 && service apache2 restart
