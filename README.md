# linepipe
[![Gem Version](https://badge.fury.io/rb/linepipe.svg)](https://rubygems.org/gems/linepipe)

Asset Pipeline for Rails with your favourite js bundler.

Install
=======

```
# Create new app or remove Sprockets from existing
rails new project --skip-sprockets

# config/application.rb
config.linepipe.manifest_file = 'config/manifest.json' # default: config/linepipe-manifest.json
config.linepipe.prefix        = '/assets'              # default: /assets
``` 

Configuration for js bundler
============================

Your js bundler should generate manifest file in JSON format:

```
# config/linepipe-manifest.json

{
  "application.js": "application-ea0d453146be2145f180.js",
  ...
}
```
