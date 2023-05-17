# Handling Subdomains and Multitenancy From Scratch (Rails 7)

---

From the GoRails video:

https://gorails.com/episodes/subdomains-and-multi-tenancy-from-scratch

Their Rails 4.2.1 example code:

https://github.com/gorails-screencasts/gorails-episode-48

---
I first created the project in Rubymine as Rails app using: 

- rails 7.0.4.3
- ruby 3.2.2
- database: postgresql
- javascript: esbuild
- additional option: 
  - --css bootstrap

After project setup in Rubymine, add .idea to .gitignore file

Then ran:

```bash
bundle exec rake db:drop db:create db:migrate db:seed
```

#### Commit: 'Initial project setup', [d4722c4](https://github.com/robault/CustomSubdomains/commit/d4722c4332ee3e2cbdd05dc59f5dc75292c863f3)

---

Added devise gem in the gemfile then ran bundle:

```bash
bundle
```

Then ran devise install:

```bash
bundle exec rails generate devise:install
```

Then created the devise user:

```bash
bundle exec rails generate devise User name
```

And created an "account" model as the subdomain holder:

```bash
bundle exec rails generate model Account subdomain user_id:integer
```

Lastly, I scaffolded the posts with an account_id because the Account will be loaded on each request based on the subdomain:

```bash
bundle exec rails generate scaffold Post title body:text account_id:integer
```

Then ran the migrations:

```bash
bundle exec rake db:migrate
```

#### Commit: 'Added devise, used generators to create objects needed for the rest of the application', [2b6ce3d](https://github.com/robault/CustomSubdomains/commit/2b6ce3d57179d2c85c45caa0b8e43d580530fe67)

I then added the simple account/subdomain before action in application controller and setup the routes.

