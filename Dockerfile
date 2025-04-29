FROM php:7.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get specific Composer version that works with Yii2
RUN curl -sS https://getcomposer.org/installer | php -- --version=1.10.22 --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod -R 777 /var/www/html/frontend/web/assets /var/www/html/backend/web/assets \
    /var/www/html/frontend/runtime /var/www/html/backend/runtime

# Install dependencies with specific Composer version
RUN composer global require "fxp/composer-asset-plugin:~1.4.7" && \
    composer install --no-dev --optimize-autoloader --ignore-platform-reqs --no-plugins && \
    composer dump-autoload -o

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost:9000/health || exit 1

# Expose port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"] 