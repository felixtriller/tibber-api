# frozen_string_literal: true

module Tibber
  class Client
    class Consumptions < Base
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

      def last(limit = nil, resolution: "HOURLY", before: nil, after: nil)
        list(resolution: resolution, last: limit || 1, before: before, after: after).then do |arr|
          limit ? arr : arr.first
        end
      end

      def first(limit = nil, resolution: "HOURLY", before: nil, after: nil)
        list(resolution: resolution, first: limit || 1, before: before, after: after).then do |arr|
          limit ? arr : arr.first
        end
      end
    end
  end
end
