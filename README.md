# Bloccit

Bloccit is a Reddit clone which is an app where people can post, vote on, share and save links and comments.

This app powers Bloccit located [here](http://damp-badlands-49860.herokuapp.com)

## Getting Started

## Software requirements

- Rails 4.2.6

- Ruby 2.3.0p0

- PostgreSQL 9.5.x or higher

## Navigate to the Rails application

```
$ cd /path/to/rails/application
```

## Set configuration files

```
$ cp config/database.yml.template config/database.yml
$ cp config/initializers/mail.rb.template config/initializers/mail.rb
```

Note:  You may need to edit the above files as necessary for your system.

## Create the database

 ```
 $ pgstart
 $ rake db:create
 ```

## Migrating and seeding the database

```
$ rake db:migrate
$ rake db:seed
```

## Starting the local server

```
$ rails server

   or

$ rails s
```

## Production Deployment

  ```
  $ git push heroku master
  $ heroku run rake db:migrate
  ```

## Support

Bug reports and feature requests can be filed with the rest for the Ruby on Rails project here:

* [File Bug Reports and Features](https://github.com/nehemiahnewell/Bloccit/issues)

## License

Bloccit is released under the [MIT license](https://mit-license.org).

## Copyright

copyright:: (c) Copyright 2015 Nehemiah Newell. All Rights Reserved.
