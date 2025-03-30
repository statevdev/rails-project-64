# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# rubocop:disable Rails/I18nLocaleAssignment
I18n.locale = ENV.fetch('RAILS_LOCALE', 'ru').to_sym
# rubocop:enable Rails/I18nLocaleAssignment

Rails.application.routes.default_url_options[:locale] = I18n.locale

module ActiveSupport
  class TestCase
    include Devise::Test::IntegrationHelpers
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
