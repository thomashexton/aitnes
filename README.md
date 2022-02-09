# README

To run this app be sure to have:
Ruby 3.1.0
Docker

PostgreSQL run in docker with:
`docker run -p 5432:5432 -e POSTGRES_USER=user -e POSTGRES_PASSWORD=password -e POSTGRES_DB=sentia_practice_development postgres:13.4`

Run:
`bundle install`
`rails db:create`
`rails db:migrate`
`rails s`

Now visit localhost:3000

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
