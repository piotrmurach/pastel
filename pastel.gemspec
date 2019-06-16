lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pastel/version'

Gem::Specification.new do |spec|
  spec.name          = "pastel"
  spec.version       = Pastel::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["me@piotrmurach.com"]
  spec.summary       = %q{Terminal strings styling with intuitive and clean API.}
  spec.description   = %q{Terminal strings styling with intuitive and clean API.}
  spec.homepage      = "https://piotrmurach.github.io/tty/"
  spec.license       = "MIT"
  if spec.respond_to?(:metadata=)
    spec.metadata = {
      "allowed_push_host" => "https://rubygems.org",
      "bug_tracker_uri"   => "https://github.com/piotrmurach/pastel/issues",
      "changelog_uri"     => "https://github.com/piotrmurach/pastel/blob/master/CHANGELOG.md",
      "documentation_uri" => "https://www.rubydoc.info/gems/pastel",
      "homepage_uri"      => spec.homepage,
      "source_code_uri"   => "https://github.com/piotrmurach/pastel"
    }
  end
  spec.files         = Dir['{lib,spec,examples}/**/*.rb']
  spec.files        += Dir['tasks/*', 'pastel.gemspec']
  spec.files        += Dir['README.md', 'CHANGELOG.md', 'LICENSE.txt', 'Rakefile']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'equatable', '~> 0.6'
  spec.add_dependency 'tty-color', '~> 0.5'

  spec.add_development_dependency 'bundler', '>= 1.5.0'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'rake'
end
