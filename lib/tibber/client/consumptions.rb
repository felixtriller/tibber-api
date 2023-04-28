# frozen_string_literal: true

module Tibber
  class Client
    class Consumptions < Base
      RESOLUTION_HOURLY  = "HOURLY"
      RESOLUTION_DAILY   = "DAILY"
      RESOLUTION_WEEKLY  = "WEEKLY"
      RESOLUTION_MONTHLY = "MONTHLY"
      RESOLUTION_ANNUAL  = "ANNUAL"

      # rubocop:disable Metrics/MethodLength, Metrics/ParameterLists
      def list(first: nil, last: nil, resolution: "HOURLY", before: nil, after: nil, filter_empty_nodes: nil)
        query(
          Graphql::Queries::ConsumptionQuery,
          home_id:            client.home_id,
          first:              first,
          last:               last,
          resolution:         resolution,
          before:             Client.to_cursor(before),
          after:              Client.to_cursor(after),
          filter_empty_nodes: filter_empty_nodes
        ) do |result|
          result.data.viewer.home.consumption.nodes.map do |data|
            Data::Consumption.from_graphql(data)
          end
        end
      end
      # rubocop:enable Metrics/MethodLength, Metrics/ParameterLists

      def last(limit = nil, resolution: "HOURLY", before: nil, after: nil, filter_empty_nodes: nil)
        list(resolution: resolution, last: limit || 1, before: before, after: after,
             filter_empty_nodes: filter_empty_nodes).then do |arr|
          limit ? arr : arr.first
        end
      end

      def first(limit = nil, resolution: "HOURLY", before: nil, after: nil, filter_empty_nodes: nil)
        list(resolution: resolution, first: limit || 1, before: before, after: after,
             filter_empty_nodes: filter_empty_nodes).then do |arr|
          limit ? arr : arr.first
        end
      end
    end
  end
end
