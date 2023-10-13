# Use the official Ubuntu Jammy image as base (22.04)
FROM ubuntu:jammy

# Update the package lists
RUN apt-get update && apt-get -y install

# PHP 7.4 ppa
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php -y

# Install PHP 7.4 and related dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    php7.4 \
    php7.4-cli \
    php7.4-common \
    php7.4-json \
    php7.4-opcache \
    php7.4-mysql \
    php7.4-mbstring \
    php7.4-xml \
    apache2 \
    libapache2-mod-php

# TODO packages composer ...

COPY index.php /var/www/html

# Set the working directory
# TODO setup /specific.. directory with mkdir copy files then set workdir
WORKDIR /var/www/html

# Setup apache
# a2enmod rewrite headers expires ext_filter send_file

# TODO download & install wkhtmltopdf binary
# TODO install mkcert and setup certificates for this image
# TODO copy over a virtual host file for apache to serve https

# Expose the necessary port if your application requires it
EXPOSE 80

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
