# symfony_docker
Trying from https://www.twilio.com/blog/get-started-docker-symfony

## Getting started
First run following command to install and create symfony stuff:
```bash
cat symfony.sh | docker exec -i php bash
```

Then copy following php code to the newly created .env.local file:
```php
DATABASE_URL="mysql://root:secret@database:3306/symfony_docker?serverVersion=8.0"
```

## php docker container
Open the php docker container over the desktop app

> You can switch the console from shell to bash!

## Create a new [entityName] entity
```bash
symfony console make:entity <entityName>
```

Add a constructor as shown below
```php
public function __construct($quote, $historian, $year) {
$this->quote = $quote;
$this->historian = $historian;
$this->year = $year;
}
```

## Create migration
```bash
symfony console make:migration
```

## Run migrations
```bash
symfony console doctrine:migrations:migrate
```

## MySQL connection settings (client)
- Connection: MariaDB or MySQL (TCP/PI)
- Host/IP: 127.0.0.1
- Username: root
- Password: {secret password from the docker-compose.yml file}
- Port: 4306
