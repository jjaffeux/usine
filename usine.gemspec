# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'usine/version'

Gem::Specification.new do |spec|
  spec.name          = "usine"
  spec.version       = Usine::VERSION
  spec.authors       = ["Joffrey JAFFEUX"]
  spec.email         = ["j.jaffeux@gmail.com"]

  spec.summary       = %q{Factories for Trailblazer’s operations}
  spec.description   = %q{Usine (french word for factory) is a small gem aiming to bring a limited feature set of factory_girl when using Trailblazer’s operations.}
  spec.homepage      = "https://github.com/jjaffeux/usine"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency             "uber"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "trailblazer", "~> 1.1"
end
