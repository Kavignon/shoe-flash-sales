# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Loading fixtures in a specific order to avoid foreign key constraint issues.
    # Rails loads the fixtures alphabetically by their filenames.
    # For instance, the InventoryItem depends on the store so the store fixture has to be loaded first.
    # Due to how things go with the all method, that would have lead to a wrong behavior (Foreign key violations found)
    fixtures :stores, :shoes, :inventory_items, :sales

    # Add more helper methods to be used by all tests here...
  end
end
