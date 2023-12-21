![MailerQ | The Most Powerful MTA](https://media.copernica.com/logos/mailerq-logo.svg "MailerQ | The Most Powerful MTA")

# Dockerfiles for the MailerQ Server
This repository contains Dockerfiles for the MailerQ server from version 5.14.0 and upward.

## License
To use the Docker images, you need a MailerQ license key. If you already have a license, you can fetch your license key [here](https://www.mailerq.com/product/license); otherwise, you can request a trial license on the MailerQ [website](https://www.mailerq.com/product/license/trial).

## Getting Started
The easiest way to run MailerQ for the first time is to use our example [docker-compose.yaml](#docker-compose), as this includes the required RabbitMQ and MySQL instances and a minimal configuration file.

### Docker Compose
An example `docker-compose.yaml` is provided in the [docker-compose](https://github.com/CopernicaMarketingSoftware/mailerq-server-docker/tree/main/docker-compose) folder. Next to the docker-compose file, you'll find a minimal config that works out of the box with the example. The docker-compose is based on the MailerQ-Server-Frontend image, which makes the MailerQ management console available on [localhost:8080](http://localhost:8080).

To run docker-compose, you need to set the environment variable `LICENSE_KEY` on your host system with a valid MailerQ [license](#license).

### Docker File
If you want to use the MailerQ images without using the docker-compose file, you need to make RabbitMQ and MySQL instances available for MailerQ.

#### Config File
You need a minimal configuration file so MailerQ can connect to RabbitMQ and MySQL.
```yaml
# the database address
database-address: mysql://user:password@host:port/database

# the queue settings
rabbitmq-address: amqp://user:password@host:port/vhost

# print application log to stdout
application-log: stdout
```

If you want to run MailerQ with the management console, you also need to provide the following.
```yaml
# Minimal management console configuration
www-port: 80
www-dir: /usr/share/mailerq/www
www-auth: hardcoded://mailerq:mailerq
```

#### License Key
A requirement, next to the config file, is the MailerQ license key or file. You can either mount an existing license file or give the `LICENSE_KEY` environment variable to the Dockerfile so it can generate a license.

#### Example
##### Without Management Console
```bash
docker build ./MailerQ-Server/ -t mailerq-server
docker run -e LICENSE_KEY=<your_mailerq_license_key> -v /path/to/minimal-config.txt:/etc/mailerq/config.txt mailerq-server
```

##### With Management Console
```bash
docker build ./MailerQ-Server-Frontend/ -t mailerq-server-frontend
docker run -e LICENSE_KEY=<your_mailerq_license_key> -v /path/to/minimal-config.txt:/etc/mailerq/config.txt mailerq-server
```