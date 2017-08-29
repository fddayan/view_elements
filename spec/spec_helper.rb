ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

# require "rails/test_help"
require "rspec/rails"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "view_elements"

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
