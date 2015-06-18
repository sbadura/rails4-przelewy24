# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'przelewy24/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails4-przelewy24'
  spec.version       = Przelewy24::VERSION
  spec.authors       = ['Mariusz Henn']
  spec.email         = ['mariusz.henn@gmail.com']
  spec.summary       = %q{przelewy24 payment provider}
  spec.description   = %q{This gem provide basic methods to communicate with przelewy24 payment system}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-rails'
end