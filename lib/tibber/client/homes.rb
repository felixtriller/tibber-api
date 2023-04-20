# frozen_string_literal: true

module Tibber
  class Client
    class Homes < Base
      def first
        list.first
      end

      def list
        query(Graphql::Queries::HomesQuery) do |result|
          result.data.viewer.homes.map do |home|
            Data::Home.from_graphql(home)
          end
        end
      end
    end
  end
end
