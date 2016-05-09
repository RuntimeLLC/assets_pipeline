module Linepipe
  module AssetUrlHelper
    extend ActiveSupport::Concern

    included do
      def compute_asset_path(path, options = {})
        asset_path_from_manifest(clean_path(super))
      end

      private

      def asset_path_from_manifest(asset_path)
        config = Rails.application.config

        rev_path = config.linepipe.manifest[asset_path] || asset_path
        [config.linepipe.prefix, rev_path].join('/')
      end

      def clean_path(path)
        path.split('/').select(&:present?).join('/')
      end
    end
  end
end
