# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'capybara/rspec'
require 'capybara/rails'

require 'selenium-webdriver'
sauce_user = ENV["SAUCE_USERNAME"]
sauce_key = ENV["SAUCE_ACCESS_KEY"]

USE_SELENIUM = ENV["USE_SELENIUM"] || (sauce_user && sauce_key)

if sauce_user && sauce_key
  #This is kind of weird -- the Sauce gem looks for this in its own namespace
  #Sauce::Selenium::WebDriver = ::Selenium::WebDriver

  require 'sauce'
  require 'sauce/capybara'
  Sauce.config do |conf|
    conf.username = sauce_user
    conf.access_key = sauce_key
    conf.browsers = [
        ["Windows 2003", "firefox", "3.6."],
        #["Linux", "firefox", "3.6."]
    ]
  end

  Capybara.default_driver = :sauce
else
  Selenium::WebDriver::Firefox::Binary.path = "/Applications/Firefox 3.6.app/Contents/MacOS/firefox-bin"
end


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|

  config.exclusion_filter = {:js => true} unless USE_SELENIUM
  #config.filter = { :focus => true }
  
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
