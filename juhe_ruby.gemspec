# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'juhe_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "juhe_ruby"
  spec.version       = JuheRuby::VERSION
  spec.authors       = ["linuxnerd"]
  spec.email         = ["lwc_evale@hotmail.com"]
  spec.description   = %q{"聚合ruby api"}
  spec.summary       = %q{"聚合ruby api"}
  spec.homepage      = "https://github.com/linuxnerd/juhe_ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
