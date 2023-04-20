# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

require "graphql/client"
require "graphql/client/http"

module Tibber
  class << self
    def root
      File.dirname(__dir__)
    end

    def configuration
      @configuration ||= Configuration.new
    end
    alias config configuration

    def configure
      yield(configuration)
    end
  end
end
