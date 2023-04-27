# frozen_string_literal: true

module Tibber
  class Error < StandardError; end

  class Client
    attr_reader :client, :context
    attr_writer :home_id

    def initialize(token: Tibber.configuration.token, home_id: nil)
      @client  = Graphql.client
      @context = { token: token }
      @home_id = home_id
    end

    def home_id
      @home_id ||= homes.first.id
    end

    def consumptions
      Consumptions.new(self)
    end

    def homes
      Homes.new(self)
    end

    def query(query, opts = {})
      client.query(query, **opts.merge(context: context)).tap do |response|
        handle_errors(response)
      end
    end

    private

    def handle_errors(response)
      raise Error, response.errors.values.flatten.join(", ") if response.errors.any?

      return if response.original_hash["errors"].blank?

      raise Error, response.original_hash["errors"].map { |e| e["message"] }.join(", ")
    end
  end
end
