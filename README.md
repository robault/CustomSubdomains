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

#### Commit: 'Initial project setup', [d4722c4](https://github.com/jlord/sheetsee.js/commit/d4722c4332ee3e2cbdd05dc59f5dc75292c863f3)

