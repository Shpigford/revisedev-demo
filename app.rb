arequire 'sentry-ruby'

Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.traces_sample_rate = 1.0 # Capture 100% of transactions for testing
  config.environment = 'development'
  config.release = '0.1.0'
  config.debug = true # Enable debug mode for testing
end

def divide_by_zero(divisor = 0)
  if divisor == 0
    'Cannot divide by zero'
  else
    1 / divisor
  end
end

  begin
    divide_by_zero
  rescue ZeroDivisionError => e
    Sentry.capture_exception(e)
    puts "Caught an error: #{e.message}"
  end

  puts "App finished."
end

main