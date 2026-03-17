#!/usr/bin/env bash

set -o errexit

bundle install

# Принудительное создание таблиц Solid Queue (если их нет)
bundle exec rails runner 'load(Rails.root.join("db/queue_schema.rb"))'

bundle exec rails db:drop
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:migrate:queue

bundle exec rails assets:precompile
bundle exec rails assets:clean
