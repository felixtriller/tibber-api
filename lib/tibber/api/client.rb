# frozen_string_literal: true

module Tibber
  module Api
    class Client
      attr_reader :client, :context

      def initialize(token: Tibber::Api.configuration.token)
        @client  = Graphql.client
        @context = { token: token }
      end

      def query(query, opts)
        client.query(query, **opts.merge(context: context))
      end

      def me
        # TODO
      end

      def homes
        query(Graphql::Queries::HomesQuery)
      end

      def home(id)
        query(Graphql::Queries::HomeQuery, variables: { id: id })
      end

      def consumptions
        # TODO
      end

      def consumption(home_id)
        # TODO
      end

      def prices
        # TODO
      end

      def price(home_id)
        # TODO
      end

      def subscriptions
        # TODO
      end

      def subscription(home_id)
        # TODO
      end

      def websocket_subscription_url(home_id)
        # TODO
      end
    end
  end
end
