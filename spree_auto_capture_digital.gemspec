# encoding: UTF-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_auto_capture_digital/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_auto_capture_digital'
  s.version     = SpreeAutoCaptureDigital::VERSION
  s.summary     = 'Auto-capture payment for digital-only orders'
  s.description = 'Enables automatic payment capture for orders containing only digital products, even when auto_capture is disabled'
  s.required_ruby_version = '>= 3.1.4'

  s.author      = 'be agile Co., Ltd.'
  s.email       = 'develop@be-agile.jp'
  s.homepage    = 'https://github.com/be-agile/spree_auto_capture_digital'
  s.licenses    = ['AGPL-3.0-or-later']

  s.files       = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'README.md']

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree', '= 5.3.6'

  # @gem-override マーカーの差分確認に使う開発ツール
  s.add_development_dependency 'gem_override_marker'
end
