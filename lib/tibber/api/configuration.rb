# frozen_string_literal: true

module Tibber
  module Api
    class Configuration
      attr_accessor :token

      def schema_path
        "#{Tibber::Api.root}/config/schema.json"
      end

      def endpoint
        "https://api.tibber.com/v1-beta/gql"
      end
    end
  end
end
