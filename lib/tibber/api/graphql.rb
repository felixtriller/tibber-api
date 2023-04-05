# frozen_string_literal: true

require "graphql/client"
require "graphql/client/http"

module Tibber
  module Api
    module Graphql
      class << self
        ENDPOINT    = "https://api.tibber.com/v1-beta/gql"
        SCHEMA_PATH = "#{Tibber::Api.root}/config/schema.json"

        def client
          @client ||= GraphQL::Client.new(schema: schema, execute: http)
        end

        def validation_client
          @validation_client ||= GraphQL::Client.new(schema: schema)
        end

        def schema
          schema! unless schema?

          @schema ||= GraphQL::Client.load_schema(schema_path)
        end

        def schema?
          File.exist?(schema_path)
        end

        def schema!
          GraphQL::Client.dump_schema(http, schema_path)
        end

        private

        def http
          @http ||= GraphQL::Client::HTTP.new(endpoint) do
            def headers(context)
              {
                Authorization: "Bearer #{context[:token]}",
                "User-Agent":  "tibber-ruby/#{Tibber::Api::VERSION}"
              }
            end
          end
        end

        def schema_path
          Tibber::Api.configuration.schema_path || SCHEMA_PATH
        end

        def endpoint
          Tibber::Api.configuration.endpoint || ENDPOINT
        end
      end
    end
  end
end
