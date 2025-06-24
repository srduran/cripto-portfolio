require 'rack'
require 'json'
require 'httparty'
require_relative 'app/main_app'
require_relative 'app/currency_converter'
require_relative 'app/cors_middleware'

# Only require pry in development
if ENV['RACK_ENV'] != 'production'
  require 'pry'
  require 'pry-byebug'
end

use CorsMiddleware
run Endpoints.new