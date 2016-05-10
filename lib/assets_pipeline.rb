module AssetsPipeline
  class Railtie < Rails::Railtie
    config.assets_pipeline = ::ActiveSupport::OrderedOptions.new

    config.assets_pipeline.manifest_file = 'config/manifest.json'

    if config.respond_to?(:assets)
      config.assets_pipeline.prefix = config.assets.prefix
    else
      config.assets_pipeline.prefix = '/assets'
    end

    config.after_initialize do
      if File.exists?(config.assets_pipeline.manifest_file)
        config.assets_pipeline.manifest = JSON.parse(File.read(config.assets_pipeline.manifest_file))
      else
        config.assets_pipeline.manifest = {}
      end
    end

    initializer 'load assets_pipeline integration' do
      ActiveSupport.on_load :action_view do
        require 'assets_pipeline/asset_url_helper'
        ::ActionView::Helpers::AssetUrlHelper.prepend ::AssetsPipeline::AssetUrlHelper
        include ::AssetsPipeline::AssetUrlHelper
      end
    end
  end
end
