FROM wordpress:latest

ENV WOOCOMMERCE_VERSION 3.8.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip wget \
    && wget https://downloads.wordpress.org/plugin/woocommerce.${WOOCOMMERCE_VERSION}.zip -O /tmp/temp.zip \
    && cd /usr/src/wordpress/wp-content/plugins \
    && unzip /tmp/temp.zip \
    && rm /tmp/temp.zip \
    && rm -rf /var/lib/apt/lists/*

