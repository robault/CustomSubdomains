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

After project setup in Rubymine, add .idea to .gitignore file.

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

---

I then added the simple account/subdomain before action in application controller and setup the routes.

#### Commit: 'Setup subdomain before_action', [414f75f](https://github.com/robault/CustomSubdomains/commit/414f75f54786135afb4e02e0e948193b5b9734a7)

---

Part of why I created such a small previous commit was to isolate the handler code for easy reference. A secondary benefit was at this point in the video, the local domain 'lvh.me' was used. In Rails 7 (6.1?), you have to specify the hosts. So the following commit calls out a modern Rails way to handle the (sub)domain.

#### Commit: 'Rails 7 host config', [6eb6794](https://github.com/robault/CustomSubdomains/commit/6eb6794a40c130d014d301206a96bf797a5ea034)

---

Next I generated the devise views to add account to sign up:

```bash
bundle exec rails generate devise:views
```

Then I added account to the sign up form.

Then added the before action in application controller to allow devise to accept the nested account attribute 'subdomain'.

The models were modified to setup active record relations, as well as create an account when saving a new user. 

Devise has changed since the video was made, so I had to modify the before action in the application controller

From the video:

```ruby
def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) { |u|
    u.permit(:email, :password, :password_confirmation, account_attributes: [:subdomain])
  }
end
```

...and the new way of doing it:

```ruby
def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:account_attributes => [:subdomain]])
end
```

From this point I was able to create an account and user, and login using 'example.lvh.me:3000'.

#### Commit: 'Devise sign up accepting account', [45efe17](https://github.com/robault/CustomSubdomains/commit/45efe1766eccfbe2044c46cf710857ad2e94d54c)

---

I then added active record relations to the post and account models linking them together.

Then edits the posts controller to pull from @account.posts instead of Post now that @account ought to be set by the application controller.

I also removed the account_id from the posts _form partial. This illustrates that the account is being set automatically.

Following the video, I opened a private browser window and created a new user and new account called "test".

This is shown in the video using "example.lvh.me:3000" and "test.lvh.me:3000".

Just "lvh.me:3000" will not work because the subdomain is required in the posts controller now.

The host Chris Oliver makes the statement that this subdomain project can go many different directions at this point.

Sounds like a good time to commit.

#### Commit: 'Isolating posts by account/subdomain', [f88579c](https://github.com/robault/CustomSubdomains/commit/f88579c1b063c75b704397d185d86310bb9fcfc6)

---
