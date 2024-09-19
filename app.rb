arequire 'sentry-ruby'

Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.traces_sample_rate = 1.0 # Capture 100% of transactions for testing
  config.environment = 'development'
  config.release = '0.1.0'
  config.debug = true # Enable debug mode for testing
end

def divide_by_zero(divisor)
  if divisor == 0
    raise ZeroDivisionError.new("Cannot divide by zero")
  else
    1 / divisor
  end
end

  begin
    result = divide_by_zero(0)
  rescue ZeroDivisionError => e
    Sentry.capture_exception(e)
    puts "Caught an error: #{e.message}"
  puts "Trying a valid division..."
  begin
    result = divide_by_zero(2)
    puts "Result of valid division: #{result}"
  rescue ZeroDivisionError => e
    Sentry.capture_exception(e)
    puts "Caught an error: #{e.message}"
  end