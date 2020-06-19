
# Autoforce_api
---------------------------

# Additional Stuff
- A security layer, to prevent script kiddies from messing up our Orders and putting on YouTube:

Installing the gems devise and simple_token_authentication we can easily create an authentication method to access our api endpoints.


- A permission layer, that way we can be sure that each user is only working with their stuff:

Using the devise gem, we can easily permit access for orders or batches created from the same user, we just need to create a user references field on the models.


- Sometimes people confuses Moto G5 with Moto G5S and we need a way to modify Orders in production:

To do that we only need to add the route update on orders resources in config/routes.rb and create one validation on order model to edit only orders on production status and maybe only some fields because I think it doesn't make sense update purchase channel or reference.


- A web UI to control everything directly, without the need of going thought the API:

To do this will be very easy, I already configured webpacker with bootstrap, jquery and fontawesomes, so we just need to create the layout on views/layout/application.html.erb using HTML, bootstrap and javascript with jquery and then create the layout of the scaffold template, then just generate the scaffold of the models, remove the controller actions and routes that we wont use, modify any views if needed, and then just create the financials page and route.

---------------------------

# Setup

## Pre-requisites

* Ruby 2.6.5
* Bundler 2.1.4
* Docker and Docker Composer (just needed if you want to run the project easily)
* Rails 6.0.3.1
* Postgresql 10.10 or later
* Redis 3.0 or later

## Setup Docker and Docker Composer
First install docker
1. `$ sudo apt install docker.io`
1. `$ sudo systemctl start docker`
1. `$ sudo systemctl enable docker`

To check installation, run:
`$ sudo docker -v`

Then install docker-compose

1. `$ sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`
1. `$ sudo chmod +x /usr/local/bin/docker-compose`

To check installation, run:
`$ docker-compose --version`

## Setup project with docker

1. `$ git clone https://github.com/raicg/autoforce_api`
1. `$ cd autoforce_api`
1. `$ cp config/database.yml.sample config/database.yml`
1. `$ cp .env.sample .env`
1. `$ docker-compose run app bundle exec rake db:create`
1. `$ docker-compose run app bundle exec rake db:migrate`

## Running locally with docker

1. `$ docker-compose build`
1. `$ docker-compose up`
1. `$ docker-compose run app bundle exec rails s -b 0.0.0.0`

## Setup project without docker
1. `$ git clone https://github.com/raicg/autoforce_api`
1. `$ cd autoforce_api`
1. `$ cp config/database.yml.sample config/database.yml`
1. `$ cp .env.sample .env`
1. `$ bundle install`
1. `$ yarn install`

To continue you will need to open an postgresql server and update config/database.yml file.

Then:

1. `$ bundle exec rails db:create`
1. `$ bundle exec rails db:migrate`

After this you will need to open an redis server and update the .env file with the redis ip.

And then you will need to open 2 servers, the worker and the web:

1. `$ bundle exec sidekiq -C config/sidekiq.yml`
1. `$ bundle exec rails s`

# API Endpoints

All endpoints was created using the jsonapi specification, find more about it: https://jsonapi.org/

You can find many clients implementations to easily use our api endpoints here: https://jsonapi.org/implementations/

## Orders index
`get api/v1/orders`
## Orders show
`get api/v1/orders/:order_id`
## Orders create
`post api/v1/orders`
## Batches index
`get api/v1/batches`
## Batches show
`get api/v1/batches/:batch_id`
## Batches create
`post api/v1/batches`
## Batches close orders
`post api/v1/batches/:batch_id/close_orders`
## Batches send orders
`post api/v1/batches/:batch_id/send_orders`

must send delivery_service as parameter

## Financials index
`get api/v1/financials`

---------------------------

## Example of how to access these endpoints without using jsonapi clients
If needed to pass a body on the the call of the endpoint (e.g when creating an order or a batch)
Headers must have this variable:

`'Content-Type': 'application/vnd.api+json'`

Body must be in json and have this structure:

Example creating an order:

```
{
	"data": {
		"type": "Orders",
		"attributes": {
			"reference": "reference",
			"purchase-channel": "purchase_channel",
			"client-name": "client_name",
			"address": "address",
			"delivery-service": "delivery_service",
			"total-value": 123.30,
			"line-items": "[{sku: case-my-best-friend, model: iPhone X, case type: Rose Leather}, {sku: powebank-sunshine, capacity: 10000mah}, {sku: earphone-standard, color: white}]"
		}
	}
}
```

Example creating a batch:

```
{
	"data": {
		"type": "batches",
		"attributes": {
			"reference": "reference",
			"purchase-channel": "purchase_channel"
		}
	}
}
```
