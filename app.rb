arequire 'sentry-ruby'

Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.traces_sample_rate = 1.0 # Capture 100% of transactions for testing
  config.environment = 'development'
  config.release = '0.1.0'
  config.debug = true # Enable debug mode for testing
end

def divide_by_zero(divisor)
  raise ZeroDivisionError, 'Cannot divide by zero' if divisor == 0
  1 / divisor
end
def main
  puts "Starting the app..."
  Sentry.capture_message("App started")

  begin
    divide_by_zero(0)
  rescue ZeroDivisionError => e
    Sentry.capture_exception(e)
    puts "Caught an error: #{e.message}"
  end

  puts "App finished."
end

main