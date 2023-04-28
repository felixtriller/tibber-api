# frozen_string_literal: true

module Tibber
  module Data
    class Price < Base
      attr_accessor :total, :energy, :tax, :currency, :level
      attr_reader :starts_at

      def starts_at=(value)
        @starts_at = DateTime.parse(value)
      end
    end
  end
end
