rails-json-api
==============

[![Code Climate](https://codeclimate.com/github/venables/rails-json-api.png)](https://codeclimate.com/github/venables/rails-json-api)

A barebones, stateless, RESTFUL Rails JSON API app, following current best practices with a focus on security.

Details
-------

* Authentication using Rails' built-in [`has_secure_password`](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password), making it minimal, well-documented, and easy to upgrade
* Stateless JSON API - no insecure sessions or cookies, so no need for CSRF tokens
* [Puma](https://github.com/puma/puma) as our web server for concurrency
* [PostgreSQL](http://www.postgresql.org/) for our data store
* UUIDs as the primary key for users
* [Resque](https://github.com/resque/resque) ([Redis](https://github.com/resque/resque)) for background processing (using [ActiveJob](https://github.com/rails/activejob))
* All emails go through ActiveJob + Resque
* Session tokens are signed as [JSON Web Tokens (JWT)](http://jwt.io/)
* Session tokens and password reset tokens are stored in redis with an expriy time
* JSON responses are rendered using jbuilder
* [RSpec](https://github.com/rspec/rspec) for tests
* Built for easy deployment to [Heroku](https://www.heroku.com/)

What's included out of the box:
-------------------------------

* User registration
* Authentication
* Forgot password / reset password flow
* List users, show given user
* A "Thanks for signing up" welcome email from the founder, delivered ~2 hours after signup


Wishlist:
---------

* Add more test coverage
* Rate limiting + Rate limit headers
* Oauth server
* Oauth signup via 3rd party services
* Two-factor authentication
* Error / Exception tracking
* Default mailer settings to use Mandrill / Sendgrid
* Admin role, section
* Option to disable Redis, use DelayedJob / other instead
* Add an install script to do the renaming (Step #2 below) automatically
* Send founder email sooner in dev mode
* Add worker auto-scaling option for Heroku
* Deployment instructions

Starting a new app
------------------

1. Clone this repo to your machine

  ```bash
  git clone https://github.com/venables/rails-json-api.git your_app_name
  ```

2. Find and replace `RailsJsonApi` with `YourAppName`, and `rails_json_api` with `your_app_name`. For example:

  ```bash
  find . | xargs perl -pi -e 's/RailsJsonApi/NewAppName/g'
  find . | xargs perl -pi -e 's/rails_json_api/new_app_name/g'
  ```

3. Pick a new foreman port in `bin/setup`

4. Run `bin/setup`

5. Delete everything in this README above `Requirements` (below)

Requirements
------------

* Postgresql (9.2 +)
* Redis
* Foreman

Get started
-----------

```bash
./bin/setup
```

Run the server
--------------

```bash
foreman start
```


## Testing

```sh
rake db:test:prepare
rake
```
