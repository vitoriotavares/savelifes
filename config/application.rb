require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SaveLives
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ["pt-BR"]
    config.i18n.default_locale = :'pt-BR'
    config.time_zone = 'America/Fortaleza'
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.assets.initialize_on_precompile = false

    config.generators do |g|
      g.assets            false
      g.system_tests      false
      g.test_framework    nil
      g.jbuilder          false
      g.factory_bot       false
    end

    config.exceptions_app = self.routes
  end
end
