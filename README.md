# Innovation Lessons

Public URL: https://privatebeta-innovationlessons.herokuapp.com


### Development Dependencies:

* Imagemagick
* ElasticSearch
* PostgreSQL


### ElasticSearch notes
In order to populate ES indexes run `Strategy.import(force: true)` on rails console

## Branching
* All feature branches are being merged into `master`
* Heroku version is keeped on `production` branch (merge master into production when you want to deploy)
