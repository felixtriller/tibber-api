# frozen_string_literal: true

module Tibber
  class Client
    class Consumptions < Base
      DEAULT_LIMIT = 100

      def list(first: nil, last: nil, resolution: "HOURLY", before: nil, after: nil)
        query(
          Graphql::Queries::ConsumptionQuery,
          home_id: client.home_id, first: first, last: last, resolution: resolution, before: before, after: after
        ) do |result|
          result.data.viewer.home.consumption.nodes.map do |data|
            Data::Consumption.from_graphql(data)
          end
        end
      end

      def last(n = DEAULT_LIMIT, resolution: "HOURLY", before: nil, after: nil)
        list(resolution: resolution, last: n, before: before, after: after)
      end

      def first(n = DEAULT_LIMIT, resolution: "HOURLY", before: nil, after: nil)
        list(resolution: resolution, first: n, before: before, after: after)
      end
    end
  end
end
