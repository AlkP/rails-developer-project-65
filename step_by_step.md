
### старт
```bash
rails new . -j esbuild --css=bootstrap
bin/rails g controller dashboards
bin/rails g system_test dashboards
bin/rails g model user email:string password_digest:string
bin/rails g controller users new create show index

bin/rails g simple_form:install
bin/rails g system_test

bin/rails g controller sessions new create destroy
bin/rails g system_test sessions
```
### render.com
грохаем файлы master.key & credentials.yml.enc. добавляем в Gemfile -> gem 'pg'

1. создаем сервис с базой данной postgre.
2. добавляем сервис Ruby и ему прописываем 3 переменных:
```angular2html
DATABASE_URL: строка подключения к БД взятая в Internal Database URL первого сервиса
SECRET_KEY_BASE: сгенерировать
RAILS_ENV: production
```
Build Command:
```bundle install; bundle exec rake assets:precompile; bundle exec rake assets:clean; bundle exec rails db:migrate; bundle exec rails db:seed;```

Start Command
```bundle exec puma -t 2:2 -p ${PORT:-3000} -e production```

### Rollbar
```bin/rails g rollbar```

добавить в переменные render.com ROLLBAR_ACCESS_TOKEN из .env
