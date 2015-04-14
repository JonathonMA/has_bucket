# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'has_bucket/version'

Gem::Specification.new do |spec|
  spec.name          = "has_bucket"
  spec.version       = HasBucket::VERSION
  spec.authors       = ["Jonathon M. Abbott"]
  spec.email         = ["jonathona@everydayhero.com.au"]
  spec.summary       = "i has an S3 bucket"
  spec.description   = "Simple wrapper around single-bucket S3 storage"
  spec.homepage      = "https://github.com/JonathonMA/has_bucket"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mime-types"
  spec.add_runtime_dependency "s3"
  spec.add_runtime_dependency "uri_config"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "rubocop", "~> 0.27.0"
  spec.add_development_dependency "vcr", "~> 2.9.3"
  spec.add_development_dependency "webmock", "~> 1.20.3"
  spec.add_development_dependency "timecop"
end
