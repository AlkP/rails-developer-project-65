#!/usr/bin/env bash

set -o errexit

bundle install

# Игнорируем защиту Rails, делать единоразово, затем комментить
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:create db:schema:load

# Принудительное создание таблиц Solid Queue (если их нет)
bundle exec rails runner 'load(Rails.root.join("db/queue_schema.rb"))'

bundle exec rails db:migrate
bundle exec rails db:migrate:queue

bundle exec rails assets:precompile
bundle exec rails assets:clean
