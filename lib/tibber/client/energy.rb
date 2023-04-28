# frozen_string_literal: true

module Tibber
  class Client
    class Energy < Base
      RESOLUTION_HOURLY  = "HOURLY"
      RESOLUTION_DAILY   = "DAILY"
      RESOLUTION_WEEKLY  = "WEEKLY"
      RESOLUTION_MONTHLY = "MONTHLY"
      RESOLUTION_ANNUAL  = "ANNUAL"

      # rubocop:disable Metrics/MethodLength, Metrics/ParameterLists
      def list(first: nil, last: nil, resolution: RESOLUTION_HOURLY, before: nil, after: nil, filter_empty_nodes: nil)
        query(
          query_class,
          home_id:            client.home_id,
          first:              first,
          last:               last,
          resolution:         resolution,
          before:             Client.to_cursor(before),
          after:              Client.to_cursor(after),
          filter_empty_nodes: filter_empty_nodes
        ) do |result|
          result.data.viewer.home.try(path).nodes.map do |data|
            data_class.from_graphql(data)
          end
        end
      end
      # rubocop:enable Metrics/MethodLength, Metrics/ParameterLists

      def last(limit = nil, resolution: RESOLUTION_HOURLY, before: nil, after: nil, filter_empty_nodes: nil)
        list(resolution: resolution, last: limit || 1, before: before, after: after,
             filter_empty_nodes: filter_empty_nodes).then do |arr|
          limit ? arr : arr.first
        end
      end

      def first(limit = nil, resolution: RESOLUTION_HOURLY, before: nil, after: nil, filter_empty_nodes: nil)
        list(resolution: resolution, first: limit || 1, before: before, after: after,
             filter_empty_nodes: filter_empty_nodes).then do |arr|
          limit ? arr : arr.first
        end
      end

      private

      # :nocov:
      def path
        raise NotImplementedError, "Implement in sub class"
      end

      def query_class
        raise NotImplementedError, "Implement in sub class"
      end

      def data_class
        raise NotImplementedError, "Implement in sub class"
      end
      # :nocov:
    end
  end
end
