Rollbar.configure do |config|
  config.access_token = ENV.fetch('ROLLBAR_ACCESS_TOKEN', nil)

  config.enabled = false if Rails.env.test?

  # Add exception exclusions
  # config.exception_level_filters['ActionController::RoutingError'] = 'ignore'

  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end
