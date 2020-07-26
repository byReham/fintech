require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_mailer/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fintech
  class Application < Rails::Application
    config.load_defaults 5.2

    config.time_zone = 'UTC'

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.i18n.available_locales = %i[en]
    config.i18n.default_locale = :en
    config.i18n.locale = :en
    config.i18n.fallbacks = [:en]

    config.autoload_paths << Rails.root.join('lib')

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :slim
      g.assets     false
      g.helper     false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
