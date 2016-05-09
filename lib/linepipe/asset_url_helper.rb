module Linepipe
  module AssetUrlHelper
    extend ActiveSupport::Concern

    included do
      def compute_asset_path(path, options = {})
        canonical_path = super(path, options).split('/').select(&:present?).join('/')
        asset_path_from_manifest(canonical_path)
      end

      private

      def asset_path_from_manifest(asset_path)
        rails_config = Rails.application.config

        rev_path = rails_config.linepipe_manifest[asset_path] || asset_path
        [rails_config.assets.prefix, rev_path].join('/')
      end
    end
  end
end
