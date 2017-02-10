# assets_pipeline
[![Gem Version](https://badge.fury.io/rb/assets_pipeline.svg)](https://rubygems.org/gems/assets_pipeline)
[![Build Status](https://travis-ci.org/llxff/assets_pipeline.svg?branch=master)](https://travis-ci.org/llxff/assets_pipeline)

Asset Pipeline for Rails with your favourite js bundler.

**JRuby is not currently supported.**

Install
=======

```
# Create new app or remove Sprockets from existing
rails new project --skip-sprockets

# config/application.rb
config.assets_pipeline.manifest_file = 'config/manifest.json' # default: config/manifest.json
config.assets_pipeline.prefix        = '/assets'              # default: /assets

config.assets_pipeline.after_manifest_initialization = -> { puts 'called after mainifest initialization' }
``` 

Configuration for js bundler
============================

Your js bundler should generate manifest file in JSON format:

```
# config/manifest.json

{
  "application.js": "application-ea0d453146be2145f180.js",
  ...
}
```
