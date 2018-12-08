ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# To add Capybara feature tests add `gem 'minitest-rails-capybara'`
# to the test group in the Gemfile and uncomment the following:
# require 'minitest/rails/capybara'

# Uncomment for awesome colorful output
require 'minitest/pride'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def self.prepare
  end
  prepare

  setup :_environment

  def _environment
    CryptoCurrency.delete_all
    Currency.delete_all

    CryptoCurrency.create([bitcoin, stellar])
    Currency.create([euro, united_states_dollar])
  end

  private

    def bitcoin
      { symbol: 'BTC', name: 'Bitcoin' }
    end

    def stellar
      { symbol: 'STR', name: 'Stellar' }
    end

    def euro
      { code: 'EUR', name: 'Euro', symbol: '€' }
    end

    def united_states_dollar
      { code: 'USD', name: 'United States Dollar', symbol: '$' }
    end
end
