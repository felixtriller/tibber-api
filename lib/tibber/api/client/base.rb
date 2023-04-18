# frozen_string_literal: true

module Tibber
  module Api
    class Client
      class Base
        attr_reader :client

        def initialize(client)
          @client = client
        end

        private

        def query(query, variables = {}, &block)
          variables.reject! { |_k, v| v.blank? }

          client.query(query, variables: variables).then do |result|
            block.call(result)
          end
        end
      end
    end
  end
end
