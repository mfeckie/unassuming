# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "unassuming"
  spec.version       = "0.0.2"
  spec.authors       = ["Martin Feckie"]
  spec.email         = ["mfeckie@gmail.com"]
  spec.summary       = %q{Unassuming is an RSpec formatter that doesn't take much space!}
  spec.description   = %q{RSpec formatter designed to live in a small terminal of ~6 lines}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "rspec", ">= 3.0"
end
