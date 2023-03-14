FROM php:5.6-apache

# en_US config
RUN apt-get update \
    && apt-get upgrade -y

RUN apt-get install -y \
    locales \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    pngquant \
    libpng-dev \
    libssl-dev \ 
    gnupg \
    ruby-full \
    libmcrypt-dev \
    libicu-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    freetds-bin \
    freetds-common \
    freetds-dev \
    libdbd-freetds \
    libqt4-sql-tds \
    libqt5sql5-tds \
    unixodbc \
    tdsodbc \
    software-properties-common 


RUN ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/ \
    && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.a /usr/lib/

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
    zip \
    bcmath \
    gd \
    xml \
    xmlrpc \
    dom \
    session \
    intl \
    mysqli \
    pdo_mysql \
    mbstring \
    soap \
    opcache \
    xsl \
    pdo \
    pdo_dblib \
    mssql \
    pdo \
    calendar

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 
ENV LANG en_US.UTF-8`

COPY ./www /var/www/html
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]