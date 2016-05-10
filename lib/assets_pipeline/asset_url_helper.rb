module AssetsPipeline
  module AssetUrlHelper
    def compute_asset_path(path, options = {})
      asset_path_from_manifest(clean_path(super))
    end

    private

    def asset_path_from_manifest(asset_path)
      config = Rails.application.config

      rev_path = config.assets_pipeline.manifest[asset_path] || asset_path
      [config.assets_pipeline.prefix, rev_path].join('/')
    end

    def clean_path(path)
      path.split('/').select(&:present?).join('/')
    end
  end
end
