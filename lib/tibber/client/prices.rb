# frozen_string_literal: true

module Tibber
  class Client
    class Prices < Base
      RESOLUTION_HOURLY  = "HOURLY"
      RESOLUTION_DAILY   = "DAILY"

      def current
        query(Graphql::Queries::PriceInfosQuery, home_id: client.home_id, last: 0) do |result|
          Data::Price.from_graphql(result.data.viewer.home.current_subscription.price_info.current)
        end
      end

      def today
        query(Graphql::Queries::PriceInfosQuery, home_id: client.home_id, last: 0) do |result|
          result.data.viewer.home.current_subscription.price_info.try(__callee__).map do |data|
            Data::Price.from_graphql(data)
          end
        end
      end
      alias tomorrow today

      # rubocop:disable Metrics/MethodLength
      def list(first: nil, last: nil, resolution: RESOLUTION_HOURLY, before: nil, after: nil)
        query(
          Graphql::Queries::PricesQuery,
          home_id:    client.home_id,
          first:      first,
          last:       last,
          resolution: resolution,
          before:     Client.to_cursor(before),
          after:      Client.to_cursor(after)
        ) do |result|
          result.data.viewer.home.current_subscription.price_info.range.nodes.map do |data|
            Data::Price.from_graphql(data)
          end
        end
      end
      # rubocop:enable Metrics/MethodLength

      def last(limit = nil, resolution: RESOLUTION_HOURLY, before: nil, after: nil)
        list(resolution: resolution, last: limit || 1, before: before, after: after).then do |arr|
          limit ? arr : arr.first
        end
      end

      def first(limit = nil, resolution: RESOLUTION_HOURLY, before: nil, after: nil)
        list(resolution: resolution, first: limit || 1, before: before, after: after).then do |arr|
          limit ? arr : arr.first
        end
      end
    end
  end
end
