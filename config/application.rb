require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WookieBooksRubyEzqubz
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.autoload_paths << Rails.root.join('lib')
    config.cache_store = :redis_cache_store, { url: 'redis://127.0.0.1:6379/0' }
    config.session_store :redis_store, servers: 'redis://127.0.0.1:6379/0'
    config.middleware.insert_after ActionDispatch::Callbacks, RequestLogger
  end
end
