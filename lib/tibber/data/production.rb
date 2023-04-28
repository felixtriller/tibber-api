# frozen_string_literal: true

module Tibber
  module Data
    class Production < Energy
      attr_accessor :profit, :production, :production_unit
    end
  end
end
