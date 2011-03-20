# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'capybara/rspec'
require 'capybara/rails'

require 'selenium-webdriver'
#Selenium::WebDriver::Firefox::Binary.path = "/Applications/Firefox 3.6.app/Contents/MacOS/firefox-bin"
require 'sauce'
require 'sauce/capybara'
#Sauce.config do |config|
  #config.username = "veganjenny"
  #config.access_key = 
  #config.browser = "firefox"
  #config.os = "Windows 2003"
  #config.browser_version = "3.6."
#end
sauce_user = ENV["SAUCE_USER"]
sauce_key = ENV["SAUCE_KEY"]

Sauce::Selenium::WebDriver = ::Selenium::WebDriver
Sauce.config do |conf|
  conf.username = sauce_user
  conf.access_key = sauce_key
  #conf.browser_url = "http://87640.test/"
  conf.browsers = [
      ["Windows 2003", "firefox", "3.6."]
  ]
  #conf.application_host = "sharp-stream-175.heroku.com"
  #conf.application_port = "3001"
end
Capybara.default_driver = :sauce
#require 'sauce'
#require 'sauce/capybara'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # transactional fixtures make Selenium an unhappy camper
  config.use_transactional_fixtures = false

  config.before do
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true

end

#Sauce.config do |conf|
    #conf.browser_url = "http://87640.test/"
    #conf.browsers = [
        #["Windows 2003", "firefox", "3.6."]
    #]
    #conf.application_host = "127.0.0.1"
    #conf.application_port = "3001"
#end
