# frozen_string_literal: true

require "rake"
require "rake/tasklib"

require "tibber/api"

module Tibber
  module Api
    class RakeTask < ::Rake::TaskLib
      def initialize
        super()

        define
      end

      def define
        namespace :tibber do
          desc "Dump schema from Tibber API"
          task :dump_schema do
            Tibber::Api::Graphql.schema!
          end
        end
      end
    end
  end
end
