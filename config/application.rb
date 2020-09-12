require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yurukotsu
  class Application < Rails::Application
    config.i18n.default_locale = :ja
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.time_zone = "Tokyo"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.to_prepare do
      Devise::SessionsController.layout "devise"
      # Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "devise" }
      Devise::RegistrationsController.layout "devise_registrations"
      Devise::ConfirmationsController.layout "devise"
      Devise::UnlocksController.layout "devise"
      Devise::PasswordsController.layout "devise_password"
    end
  end
end
