#!/usr/bin/bash

symfony check:requirements;
symfony new .;
composer req --dev maker ormfixtures fakerphp/faker;
composer req doctrine twig;
cp .env .env.local