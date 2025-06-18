require 'rack'
require 'pry'
require 'pry-byebug'
require 'json'
require 'httparty'
require_relative 'app/main_app'
require_relative 'app/currency_converter'

run Endpoints.new