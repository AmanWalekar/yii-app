# Yii2 Shop - DevOps Assessment

This project demonstrates the deployment of a Yii2 PHP application using Docker Swarm, NGINX, and automated CI/CD pipelines.

## 🚀 Features

- Docker Swarm for container orchestration
- NGINX as a reverse proxy
- Automated deployment with GitHub Actions
- Infrastructure automation with Ansible
- Health checks and monitoring
- High availability with multiple replicas

## 📋 Prerequisites

- AWS EC2 instance (Ubuntu 20.04 LTS recommended)
- Docker Hub account
- GitHub repository
- Domain name (optional)

## 🔧 Setup Instructions

### 1. EC2 Instance Setup

1. Launch an EC2 instance with Ubuntu 20.04 LTS
2. Configure security groups to allow:
   - SSH (22)
   - HTTP (80)
   - HTTPS (443)
   - Docker Swarm ports (2377, 7946, 4789)

### 2. GitHub Secrets Setup

Add the following secrets to your GitHub repository:
- `DOCKER_USERNAME`: Your Docker Hub username
- `DOCKER_PASSWORD`: Your Docker Hub password
- `EC2_HOST`: Your EC2 instance public IP
- `EC2_USERNAME`: EC2 instance username (usually 'ubuntu')
- `EC2_SSH_KEY`: Your SSH private key

### 3. Infrastructure Setup

1. Clone this repository to your local machine
2. Update the `app_domain` variable in `ansible/playbook.yml`
3. Run the Ansible playbook:
   ```bash
   ansible-playbook -i inventory.ini ansible/playbook.yml
   ```

### 4. Application Deployment

1. Push your code to the main branch
2. GitHub Actions will automatically:
   - Build the Docker image
   - Push it to Docker Hub
   - Deploy to your EC2 instance
   - Run health checks

## 🛠 Testing the Deployment

1. Frontend: `http://your-domain.com`
2. Backend: `http://admin.your-domain.com`
3. Health check: `http://your-domain.com/health`

## 🔍 Monitoring

The application includes basic health checks. For production, consider adding:
- Prometheus for metrics collection
- Grafana for visualization
- Node Exporter for system metrics

## 🔄 Rollback Procedure

If deployment fails, you can manually rollback:
```bash
docker service update --rollback yii2-shop_app
```

## 📝 Assumptions

1. The EC2 instance has sufficient resources (2GB RAM minimum)
2. Domain name is configured and pointing to EC2 instance
3. SSL certificates are managed separately (recommended: Let's Encrypt)
4. Database is properly backed up

## 🔐 Security Considerations

1. Use strong passwords for all services
2. Implement proper SSL/TLS
3. Regular security updates
4. Proper firewall rules
5. Regular backups

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE.md file for details

Yii 2 shop example project
==========================

This is an example project implementing a shop created to help people learn Yii 2.0. It was created during 8 hours workshop performed in Ekaterinburg, Russia. The idea was to show how to deal with Gii, grids, filtering and other Yii 2.0 usage. It is by no means a complete shop script. It may contain bugs, shortcuts etc.

> If you want to take over the project and develop it further, let @samdark know and you'll be granted permissions required.

There are slides from the workshop in Russian: http://slides.rmcreative.ru/2014/yii2-master/

It is built on top of advanced template which includes three tiers: front end, back end, and console, each of which
is a separate Yii application.

DIRECTORY STRUCTURE
-------------------

```
common
    config/              contains shared configurations
    mail/                contains view files for e-mails
    models/              contains model classes used in both backend and frontend
console
    config/              contains console configurations
    controllers/         contains console controllers (commands)
    migrations/          contains database migrations
    models/              contains console-specific model classes
    runtime/             contains files generated during runtime
backend
    assets/              contains application assets such as JavaScript and CSS
    config/              contains backend configurations
    controllers/         contains Web controller classes
    models/              contains backend-specific model classes
    runtime/             contains files generated during runtime
    views/               contains view files for the Web application
    web/                 contains the entry script and Web resources
frontend
    assets/              contains application assets such as JavaScript and CSS
    config/              contains frontend configurations
    controllers/         contains Web controller classes
    models/              contains frontend-specific model classes
    runtime/             contains files generated during runtime
    views/               contains view files for the Web application
    web/                 contains the entry script and Web resources
    widgets/             contains frontend widgets
vendor/                  contains dependent 3rd-party packages
environments/            contains environment-based overrides
tests                    contains various tests for the advanced application
    codeception/         contains tests developed with Codeception PHP Testing Framework
```


REQUIREMENTS
------------

The minimum requirement by this application template that your Web server supports PHP 5.4.0.


INSTALLATION
------------

### Install via Composer

If you do not have [Composer](http://getcomposer.org/), you can install it by following the instructions
at [getcomposer.org](http://getcomposer.org/doc/00-intro.md#installation-nix).

You can then install the application using the following command:

~~~
git clone https://github.com/samdark/yii2-shop.git
composer self-update
composer global require "fxp/composer-asset-plugin:~1.1.1"
cd yii2-shop
composer install
~~~


GETTING STARTED
---------------

After you install the application, you have to conduct the following steps to initialize
the installed application. You only need to do these once for all.

1. Run command `init` to initialize the application with a specific environment.
2. Create a new database and adjust the `components['db']` configuration in `common/config/main-local.php` accordingly.
3. Apply migrations with console command `yii migrate`. This will create tables needed for the application to work.
4. Set document roots of your Web server:

- for frontend `/path/to/yii2shop/frontend/web/` and using the URL `http://shop.local/`
- for backend `/path/to/yii2shop/backend/web/` and using the URL `http://admin.shop.local/`

To login into the application, you need to first sign up, with any of your email address, username and password.
Then, you can login into the application with same email address and password at any time.
