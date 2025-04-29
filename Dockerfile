FROM php:7.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    wget

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Create application directory and set permissions
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Set Git safe directory
RUN git config --global --add safe.directory /var/www/html

# Copy application files
COPY --chown=www-data:www-data . /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod -R 777 /var/www/html/frontend/web/assets && \
    chmod -R 777 /var/www/html/backend/web/assets && \
    chmod -R 777 /var/www/html/frontend/runtime && \
    chmod -R 777 /var/www/html/backend/runtime

# Install dependencies with specific versions
RUN composer config -g allow-plugins.yiisoft/yii2-composer true && \
    composer config -g allow-plugins.fxp/composer-asset-plugin true && \
    composer global require "fxp/composer-asset-plugin:~1.4.7" && \
    composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost:9000/health || exit 1

# Expose port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"] 