# frozen_string_literal: true

require "rake"
require "rake/tasklib"

require "tibber"

module Tibber
  class RakeTask < ::Rake::TaskLib
    def initialize
      super()

      define
    end

    def define
      namespace :tibber do
        desc "Dump schema from Tibber API"
        task :dump_schema do
          Tibber::Graphql.schema!
        end
      end
    end
  end
end
