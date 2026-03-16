ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'integration_test'

# Теперь OmniAuth в тестах не обращается к внешним источникам
OmniAuth.config.test_mode = true
OmniAuth.config.allowed_request_methods = %i[post get]
# OmniAuth.config.silence_get_warning = true

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
