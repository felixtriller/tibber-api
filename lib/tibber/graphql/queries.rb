# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module Tibber
  module Graphql
    module Queries
      HomesQuery = Graphql.validation_client.parse <<-'GRAPHQL'
        query {
          viewer {
            homes {
              id
              appNickname
            }
          }
        }
      GRAPHQL

      ConsumptionQuery = Graphql.validation_client.parse <<-'GRAPHQL'
        query(
          $home_id: ID!,
          $resolution: EnergyResolution!,
          $first: Int,
          $last: Int,
          $before: String,
          $after: String,
          $filter_empty_nodes: Boolean
        ) {
          viewer {
            home(id: $home_id) {
              consumption(
                resolution: $resolution,
                first: $first,
                last: $last,
                before: $before,
                after: $after,
                filterEmptyNodes: $filter_empty_nodes
              ) {
                nodes {
                  from
                  to
                  cost
                  currency
                  unitPrice
                  unitPriceVAT
                  consumption
                  consumptionUnit
                }
              }
            }
          }
        }
      GRAPHQL

      ProductionQuery = Graphql.validation_client.parse <<-'GRAPHQL'
        query(
          $home_id: ID!,
          $resolution: EnergyResolution!,
          $first: Int,
          $last: Int,
          $before: String,
          $after: String,
          $filter_empty_nodes: Boolean
        ) {
          viewer {
            home(id: $home_id) {
              production(
                resolution: $resolution,
                first: $first,
                last: $last,
                before: $before,
                after: $after,
                filterEmptyNodes: $filter_empty_nodes
              ) {
                nodes {
                  from
                  to
                  profit
                  currency
                  unitPrice
                  unitPriceVAT
                  production
                  productionUnit
                }
              }
            }
          }
        }
      GRAPHQL

      PriceInfosQuery = Graphql.validation_client.parse <<-'GRAPHQL'
        query(
          $home_id: ID!
        ) {
          viewer {
            home(id: $home_id) {
              currentSubscription{
                priceInfo{
                  current{
                    total
                    energy
                    tax
                    startsAt
                    currency
                    level
                  }
                  today {
                    total
                    energy
                    tax
                    startsAt
                    currency
                    level
                  }
                  tomorrow {
                    total
                    energy
                    tax
                    startsAt
                    currency
                    level
                  }
                }
              }
            }
          }
        }
      GRAPHQL

      PricesQuery = Graphql.validation_client.parse <<-'GRAPHQL'
        query(
          $home_id: ID!,
          $resolution: PriceResolution!,
          $first: Int,
          $last: Int,
          $before: String,
          $after: String,
        ) {
          viewer {
            home(id: $home_id) {
              currentSubscription{
                priceInfo{
                  range(
                    resolution: $resolution,
                    first: $first,
                    last: $last,
                    before: $before,
                    after: $after
                  ) {
                    nodes {
                      total
                      energy
                      tax
                      startsAt
                      currency
                      level
                    }
                  }
                }
              }
            }
          }
        }
      GRAPHQL
    end
  end
end
# rubocop:enable Metrics/ModuleLength
