# frozen_string_literal: true

require_relative "api/version"

module Tibber
  module Api
    class << self
      def root
        File.expand_path("../..", __dir__)
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
end

require "tibber/api/configuration"
require "tibber/api/client"
require "tibber/api/graphql"
require "tibber/api/graphql/fragments"
require "tibber/api/graphql/queries"
