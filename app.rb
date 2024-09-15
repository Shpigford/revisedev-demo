arequire 'sentry-ruby'

Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.traces_sample_rate = 1.0 # Capture 100% of transactions for testing
  config.environment = 'development'
  config.release = '0.1.0'
  config.debug = true # Enable debug mode for testing
end

def divide_by_zero(numerator, denominator)
  denominator.zero? ? nil : numerator / denominator
end

def main
  puts "Starting the app..."
  Sentry.capture_message("App started")

  begin
    result = divide_by_zero(1, 0)
    if result.nil?
      puts "Cannot divide by zero"
    else
      puts "Result: #{result}"
    end
  rescue => e
end

main