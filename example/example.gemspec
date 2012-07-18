# -*- encoding: utf-8 -*-
require File.expand_path('../lib/example/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["SATOH Fumiyasu"]
  gem.email         = ["fumiyas@osstech.co.jp"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "example"
  gem.require_paths = ["lib"]
  gem.version       = Example::VERSION
end
