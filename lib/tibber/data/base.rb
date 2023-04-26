# frozen_string_literal: true

module Tibber
  module Data
    class Base
      def initialize(attrs = {})
        attrs.each do |key, value|
          send("#{key}=", value)
        end
      end

      def attributes
        instance_variables.to_h do |var|
          [var[1..].to_sym, instance_variable_get(var)]
        end
      end

      class << self
        def from_graphql(data)
          new(**data.to_h.transform_keys(&:underscore))
        end
      end
    end
  end
end
