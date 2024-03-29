# frozen_string_literal: true

module Tibber
  class Client
    class Consumptions < Energy
      private

      def query_class
        Graphql::Queries::ConsumptionQuery
      end

      def data_class
        Data::Consumption
      end

      def path
        :consumption
      end
    end
  end
end
