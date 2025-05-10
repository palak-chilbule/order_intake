# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
3.2.2

* Rails version 
7.1.5

* System dependencies

* Configuration

* Database creation
    rails db:create

* Database initialization
    rails db:migrate

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* API endpoins
    POST api/v1/orders
    POST api/v1/orders/:id/lock
    GET api/v1/sku-summary/:sku