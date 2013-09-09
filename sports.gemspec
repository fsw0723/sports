# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sports/version'

Gem::Specification.new do |spec|
  spec.name          = "sports"
  spec.version       = Sports::VERSION
  spec.authors       = ["fsw0723"]
  spec.email         = ["haha876@163.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
