# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloudwars/version'

Gem::Specification.new do |gem|
  gem.name          = "cloudwars"
  gem.version       = Cloudwars::VERSION
  gem.authors       = ["addisaden"]
  gem.email         = ["addis.aden@gmail.com"]
  gem.description   = %q{Cloudwars is a simple round-based game}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
