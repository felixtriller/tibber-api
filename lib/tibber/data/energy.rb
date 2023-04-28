# frozen_string_literal: true

module Tibber
  module Data
    class Energy < Base
      attr_accessor :currency, :unit_price, :unit_price_vat
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
