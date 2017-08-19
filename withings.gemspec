# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "withings/version"

Gem::Specification.new do |spec|
  spec.name          = "withings"
  spec.version       = Withings::VERSION
  spec.authors       = ["Eiji MATSUMOTO"]
  spec.email         = ["e.mattsan@gmail.com"]

  spec.summary       = %q{tools for Withings' data}
  spec.description   = %q{tools for Withings' data.}
  spec.homepage      = "https://github.com/mattsan/withings"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://github.com/mattsan/withings"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
