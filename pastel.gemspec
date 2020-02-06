require_relative "lib/pastel/version"

Gem::Specification.new do |spec|
  spec.name          = "pastel"
  spec.version       = Pastel::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.summary       = %q{Terminal strings styling with intuitive and clean API.}
  spec.description   = %q{Terminal strings styling with intuitive and clean API.}
  spec.homepage      = "https://ttytoolkit.org"
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
  spec.files         = Dir["lib/**/*", "README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.extra_rdoc_files = ["README.md", "CHANGELOG.md"]
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.0.0")

  spec.add_dependency "equatable", "~> 0.6"
  spec.add_dependency "tty-color", "~> 0.5"
end
