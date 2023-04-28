# frozen_string_literal: true

module Tibber
  module Data
    class Consumption < Energy
      attr_accessor :cost, :consumption, :consumption_unit
    end
  end
end
