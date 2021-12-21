# symfony_docker
Trying from https://www.twilio.com/blog/get-started-docker-symfony

## Getting started
First run following command to build the docker container:
```bash
docker compose up -d
```

Wait till the containers are generated. Then install and create symfony stuff with:
```bash
cat symfony.sh | docker exec -i PROJECTNAME-php-1 bash
```

Wait till the process has finished. Then copy following code to the newly created .env.local file and adjust the db name:
```bash
DATABASE_URL="mysql://root:secret@database:3306/PROJECTNAME?serverVersion=8.0"
```

## Check for localhost
The application is now accessible by running `http://localhost:8080` in your browser. You should see the welcomepage from Symfony.

## php docker container
Open the console from PROJECTNAME-php-1 docker container over the desktop app

> You can switch the console from shell to bash!

## Create a new entity
```bash
symfony console make:entity <ENTITYNAME>
```

## Add fields
Now you are prompted to add some fields. Follow the instructions.

## Missing constructor
Add a constructor as shown below in the generated entity in src/Entity/ENTITYNAME.php file.
```php
public function __construct($property1, $property2, $property3, ...) {
	$this->property1 = $property1;
	$this->property2 = $property2;
	$this->property3 = $property3;
	...
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

## Creating fixtures to load data in the db
```bash
symfony console make:fixture ENTITYNAMEFixture
```

## Update the fixture file
Add
```php
...
use Faker\Factory;

class ENTITYNAMEFixture extends Fixture {

    private $faker;

    public function __construct() {

        $this->faker = Factory::create();
    }

    public function load(ObjectManager $manager) {

        for ($i = 0; $i < 50; $i++) {
            $manager->persist($this->getENTITYNAME());
        }
        $manager->flush();
    }

    private function getENTITYNAME() {

        return new ENTITYNAME(
            $this->faker->property1(10),
            $this->faker->property2(),
            $this->faker->property3(),
            ...
        );
    }
}
```
to the src/DataFixtures/ENTITYNAMEFixture.php file.

## Load fixtures
```bash
symfony console doctrine:fixtures:load
```

## Creating a controller
```bash
symfony console make:controller ENTITYNAMEController
```

## Update controller
```php
use App\Repository\ENTITYNAMERepository;
```
Set index paramter:
```php
ENTITYNAMERepository $ENTITYNAMERepository
```
and renderer array:
```php
'ENTITYNAMECONTROLLERNAME' => $ENTITYNAMERepository->findAll(),
```

## Style the view with bootstrap
Add following html code to app/templates/base.html.twig:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
            crossorigin="anonymous">

    <title>{% block title %}Welcome!{% endblock %}</title>
    {% block stylesheets %}
    {% endblock %}

    {% block javascripts %}
    {% endblock %}
</head>
<body>
{% block body %}{% endblock %}
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
        crossorigin="anonymous">
</script>
</body>
</html>
```
and app/templates/ENTITYNAME/index.html.twig
```html
{% extends 'base.html.twig' %}

{% block title %}ENTITYNAMES{% endblock %}

{% block body %}
    <style>
        .wrapper {
            margin: 1em auto;
            width: 95%;
        }
    </style>

    <div class="wrapper">
        <h1>Great ENTITYNAMES</h1>
        <table class="table table-striped table-hover table-bordered">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Property1</th>
                <th scope="col">Property2</th>
                <th scope="col">Property3</th>
                <th scope="col">...</th>
            </tr>
            </thead>
            <tbody>
            {% for ENTITYNAME in ENTITYNAMES %}
                <tr>
                    <td>{{ loop.index }}</td>
                    <td>{{ ENTITYNAME.property1 }}</td>
                    <td>{{ ENTITYNAME.property2 }}</td>
                    <td>{{ ENTITYNAME.property3 }}</td>
                    <td>{{ ... }}</td>
                </tr>
            {% endfor %}
            </tbody>
        </table>
    </div>
{% endblock %}
```