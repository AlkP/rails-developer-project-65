.PHONY: setup lint db-test-prepare test acceptance-test server console db-migrate db-seed restart

# Установка зависимостей
setup:
	@echo "🔧 Setting up the Rails application..."
	bundle install
	yarn install
	cp config/database.yml.example config/database.yml || echo "Database config already exists"
	cp .env.example .env || echo ".env file already exists"

# Подготовка тестовой БД
lint:
	@echo "🛡 check linter..."
	bundle exec rubocop
# 	bundle exec slim-lint app/views/

# Подготовка тестовой БД
db-test-prepare:
	@echo "⚙️ Preparing test database..."
	bundle exec rails db:test:prepare

# Запуск тестов
test: db-migrate db-test-prepare
	@echo "🧪 Running tests..."
# 	bundle exec rspec
	bundle exec rails test

# Запуск приемочных тестов
acceptance-test: db-migrate db-test-prepare
	@echo "🧪 Running acceptance tests..."
	bundle exec rails test:system

# Запуск сервера разработки
start:
	@echo "🚀 Starting Rails server..."
	bundle exec rails server

# Запуск консоли Rails
console:
	@echo "💻 Starting Rails console..."
	bundle exec rails console

# Миграции базы данных
db-migrate:
	@echo "🛠️  Running database migrations..."
	bundle exec rails db:migrate

# Заполнение базы данных
db-seed:
	@echo "🌱 Seeding database..."
	bundle exec rails db:seed

# Перезапуск сервера (остановка + запуск)
restart: stop server

# Остановка сервера (если запущен)
stop:
	@echo "⏹️  Stopping Rails server..."
	pkill -f "rails server" || echo "No Rails server running"

# Очистка временных файлов
clean:
	@echo "🗑️  Cleaning temporary files..."
	rm -rf tmp/cache/*
	rm -rf log/*.log

# Полный цикл установки и запуска
deploy: setup db-migrate db-seed server
