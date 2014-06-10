require 'omniauth'
require 'omniauth-salesforce'

SALESFORCE_CONFIG = YAML.load_file("#{::Rails.root}/config/salesforce.yml")[::Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :salesforce, SALESFORCE_CONFIG['key'], SALESFORCE_CONFIG['secret']
end

