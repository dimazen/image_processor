# config.ru (run with rackup)
require './image_processor.rb'
require 'rack/contrib'

use Rack::PostBodyContentTypeParser

run ImageProcessor
