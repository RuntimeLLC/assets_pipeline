describe ActionView::Helpers::AssetUrlHelper do
  let(:app) do
    app = Class.new(Rails::Application)
    app.config.eager_load = false
    app.config.assets_pipeline.manifest_file = File.join('spec', 'fixtures', 'manifest.json')
    app
  end

  let(:helper) { ActionView::Base.new }

  describe 'asset_path' do
    before { app.initialize! }

    context 'when chunk present' do
      it 'should return javascript' do
        expect(helper.asset_path(:index, type: :javascript)).to eq '/assets/index-ea0d453146be2145f180.js'
      end

      it 'should return stylesheet' do
        expect(helper.asset_path(:index, type: :stylesheet)).to eq '/assets/index-ea0d453146be2145f180.css'
      end

      it 'should return font' do
        expect(helper.asset_path('arial.eot', type: :font)).to eq '/assets/fonts/arial.ttf'
      end
    end

    context 'when chunk not found in webpack manifest' do
      it 'should return javascript' do
        expect(helper.asset_path('application.js')).to eq '/assets/application-ea0d453146be2145f180.js'
      end

      it 'should return stylesheet' do
        expect(helper.asset_path('application.css')).to eq '/assets/application-ea0d453146be2145f180.css'
      end

      it 'should return font' do
        expect(helper.asset_path('fonts/arial.eot')).to eq '/assets/fonts/arial.ttf'
      end
    end

    context 'when asset was not found in manifest' do
      it 'should return itself' do
        expect(helper.asset_path('asset.js')).to eq '/assets/asset.js'
      end
    end
  end

  describe 'stylesheet_link_tag' do
    it 'should return link tag with valid css file' do
      expect(helper.stylesheet_link_tag('index', media: 'all')).to match 'assets/index-ea0d453146be2145f180.css'
    end
  end

  describe 'callback call' do
    let(:callback) { spy }

    before do
      app.config.assets_pipeline.after_manifest_initialization = -> { callback.call }
      app.initialize!
    end

    it 'should run callback' do
      expect(callback).to have_received :call
    end
  end
end
