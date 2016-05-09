module Linepipe
  class Railtie < Rails::Railtie
    config.to_prepare do
      Linepipe.setup!
    end

    initializer 'load linepipe integration' do
      ActiveSupport.on_load :action_view do
        require 'linepipe/asset_url_helper'
        include AssetUrlHelper
      end
    end
  end

  def self.setup!
    config = Rails.configuration
    config.linepipe_manifest_fil = 'config/linepipe-manifest.json'

    if File.exists?(config.linepipe_manifest_file)
      config.linepipe_manifest = JSON.parse(File.read(config.linepipe_manifest_file))
    else
      config.linepipe_manifest = {}
    end
  end
end
