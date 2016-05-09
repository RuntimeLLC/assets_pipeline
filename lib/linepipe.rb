module Linepipe
  class Railtie < Rails::Railtie
    config.linepipe_manifest_file = 'config/linepipe-manifest.json'

    if File.exists?(config.linepipe_manifest_file)
      config.linepipe_manifest = JSON.parse(File.read(config.linepipe_manifest_file))
    else
      Rails.logger.warn "Can not find manifest file with path #{ config.linepipe_manifest_file }"
      config.linepipe_manifest = {}
    end

    initializer 'load linepipe integration' do
      ActiveSupport.on_load :action_view do
        require 'linepipe/asset_url_helper'
        include AssetUrlHelper
      end
    end
  end
end
