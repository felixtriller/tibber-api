# frozen_string_literal: true

module Tibber
  module Api
    module Graphql
      class << self
        def client
          @client ||= GraphQL::Client.new(schema: schema, execute: http)
        end

        def validation_client
          @validation_client ||= GraphQL::Client.new(schema: schema)
        end

        def schema
          schema! unless schema?

          @schema ||= GraphQL::Client.load_schema(Tibber::Api.configuration.schema_path)
        end

        def schema?
          File.exist?(Tibber::Api.configuration.schema_path)
        end

        def schema!
          GraphQL::Client.dump_schema(http, Tibber::Api.configuration.schema_path)
        end

        def http
          @http ||= GraphQL::Client::HTTP.new(Tibber::Api.configuration.endpoint) do
            def headers(context)
              {
                Authorization: "Bearer #{context[:token]}",
                "User-Agent":  "tibber-ruby #{Tibber::Api::VERSION}"
              }
            end
          end
        end
      end
    end
  end
end
