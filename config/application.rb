require File.expand_path('../boot', __FILE__)
require 'rails/all'
require 'csv'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  # Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  Bundler.require(:default, :assets, Rails.env)
end

module Answers
  class Application < Rails::Application

    config.autoload_paths += Dir["#{config.root}/lib", "#{config.root}/lib/**/"]

    config.cache_store = :dalli_store

    # Enable tables in the content fields for Articles
    config.action_view.sanitized_allowed_tags = 'table', 'tr', 'td'

    config.active_record.schema_format = :sql

  end
end
