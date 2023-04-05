# frozen_string_literal: true

require_relative "lib/tibber/api/version"

Gem::Specification.new do |spec|
  spec.name = "tibber-api"
  spec.version = Tibber::Api::VERSION
  spec.authors = ["Felix Triller"]
  spec.email = ["felixtriller@gmail.com"]

  spec.summary = "A Ruby client for the Tibber GraphQL API"
  # spec.description = "Write a longer description or delete this line."
  spec.homepage = "https://github.com/felixtriller/tibber-api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "graphql-client", "~> 0.18"

  spec.metadata["rubygems_mfa_required"] = "true"
end
