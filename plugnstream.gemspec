# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plugnstream/version'

Gem::Specification.new do |spec|
  spec.name          = "plugnstream"
  spec.version       = Plugnstream::VERSION
  spec.authors       = ["Julien Bordellier"]
  spec.email         = ["julien@plugandstream.com"]
  spec.summary       = "The plugnstream gem is the full utility to run the server side application."
  spec.description   = "This gem is composed of 3 different parts, the dispatcher which will access the database and redirect clients and ressources, the session server which will be assigned to one client for each streaming session and the streaming server which the video and audio stream manager."
  spec.homepage      = "http://plugandstream.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.2"
end
