# frozen_string_literal: true

module Tibber
  class Client
    class Productions < Energy
      private

      def query_class
        Graphql::Queries::ProductionQuery
      end

      def data_class
        Data::Production
      end

      def path
        :production
      end
    end
  end
end
