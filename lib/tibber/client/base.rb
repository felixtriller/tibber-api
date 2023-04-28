# frozen_string_literal: true

module Tibber
  class Client
    class Base
      attr_reader :client

      def initialize(client)
        @client = client
      end

      private

      def query(query, variables = {}, &block)
        variables.compact!

        client.query(query, variables: variables).then do |result|
          block.call(result)
        end
      end
    end
  end
end
