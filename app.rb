arequire 'sentry-ruby'

Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.traces_sample_rate = 1.0 # Capture 100% of transactions for testing
  config.environment = 'development'
  config.release = '0.1.0'
  config.debug = true # Enable debug mode for testing
end

def divide(numerator, denominator)
  denominator.zero? ? nil : numerator / denominator
end

def main
  puts "Starting the app..."
  Sentry.capture_message("App started")

  begin
    result = divide(1, 0)
    if result.nil?
      raise ZeroDivisionError, "Cannot divide by zero"
    end
  rescue ZeroDivisionError => e
    Sentry.capture_exception(e)
    puts "Caught an error: #{e.message}"
  end

  puts "Performing a valid division:"
  result = divide(10, 2)
  puts "10 / 2 = #{result}"

  puts "App finished."
end