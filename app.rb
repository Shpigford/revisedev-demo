arequire 'sentry-ruby'

Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.traces_sample_rate = 1.0 # Capture 100% of transactions for testing
  config.environment = 'development'
  config.release = '0.1.0'
  config.debug = true # Enable debug mode for testing
end

def divide(numerator, denominator)
  if denominator.zero?
    raise ZeroDivisionError, "Cannot divide by zero"
  else
    numerator / denominator
  end
end

  begin
    result = divide(1, 0)
  rescue ZeroDivisionError => e
    Sentry.capture_exception(e)
    puts "Caught an error: #{e.message}"
  begin
    result = divide(10, 2)
    puts "Successful division: #{result}"
  rescue => e
    Sentry.capture_exception(e)
    puts "Caught an unexpected error: #{e.message}"
  end