# frozen_string_literal: true

module Tibber
  module Api
    class Home
      attr_reader :client

      def initialize(client)
        @client = client
      end
    end
  end
end
