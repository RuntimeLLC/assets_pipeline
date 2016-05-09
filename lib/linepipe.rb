module Linepipe
  class Railtie < Rails::Railtie
    config.linepipe = ::ActiveSupport::OrderedOptions.new
    config.linepipe.manifest_file = 'config/linepipe-manifest.json'

    if config.respond_to?(:assets)
      config.linepipe.prefix = config.assets.prefix
    else
      config.linepipe.prefix = '/assets'
    end

    config.after_initialize do
      if File.exists?(config.linepipe.manifest_file)
        config.linepipe.manifest = JSON.parse(File.read(config.linepipe.manifest_file))
      else
        config.linepipe.manifest = {}
      end
    end

    initializer 'load linepipe integration' do
      ActiveSupport.on_load :action_view do
        require 'linepipe/asset_url_helper'
        include AssetUrlHelper
      end
    end
  end
end
