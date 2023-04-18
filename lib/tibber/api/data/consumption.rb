# frozen_string_literal: true

module Tibber
  module Api
    module Data
      class Consumption < Base
        attr_accessor :cost, :currency, :unit_price, :unit_price_vat, :consumption, :consumption_unit
        attr_reader :from, :to

        def from=(value)
          @from = DateTime.parse(value)
        end

        def to=(value)
          @to = DateTime.parse(value)
        end
      end
    end
  end
end
