require 'rack'
require 'pry'
require 'pry-byebug'
require 'json'
require 'httparty'
require_relative 'app/main_app'
require_relative 'app/currency_converter'
require_relative 'app/cors_middleware'

use CorsMiddleware
run Endpoints.new