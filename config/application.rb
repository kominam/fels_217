require_relative "boot"

require "rails/all"
require "csv"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fels217
  class Application < Rails::Application
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
