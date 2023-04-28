# frozen_string_literal: true

require "simplecov"
require "simplecov-cobertura"
require "simplecov-console"
SimpleCov.start do
  add_filter "/spec/"
end

SimpleCov.formatter = if ENV["CI"]
                        SimpleCov::Formatter::CoberturaFormatter
                      else
                        SimpleCov::Formatter::MultiFormatter.new(
                          [
                            SimpleCov::Formatter::HTMLFormatter,
                            SimpleCov::Formatter::Console
                          ]
                        )
                      end

require "tibber"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

Dir[File.join(Tibber.root, "spec/support/**/*.rb")].sort.each do |file|
  require file
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include ClientHelpers
end
