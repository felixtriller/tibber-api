# frozen_string_literal: true

module Tibber
  class Home
    attr_reader :client

    def initialize(client)
      @client = client
    end
  end
end
