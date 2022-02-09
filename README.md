# README

To run this app be sure to have these installed locally:
Ruby 3.1.0
Docker

PostgreSQL run in docker with:

```bash
docker run -p 5432:5432 -e POSTGRES_USER=user -e POSTGRES_PASSWORD=password -e POSTGRES_DB=sentia_practice_development postgres:13.4
```

Run:
`bundle install`
`rails db:create`
`rails db:migrate`
`rails s`

Visit localhost:3000 and import away.
