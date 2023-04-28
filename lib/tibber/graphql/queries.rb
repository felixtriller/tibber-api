# frozen_string_literal: true

module Tibber
  module Graphql
    module Queries
      HomeQuery = Graphql.validation_client.parse <<-'GRAPHQL'
        query($id: ID!) {
          viewer {
            home(id: $id) {
              id
              timeZone
              appNickname
              appAvatar
              size
              type
              numberOfResidents
              primaryHeatingSource
              hasVentilationSystem
              mainFuseSize
              address {
                ...Tibber::Graphql::Fragments::AddressFragment
              }
              owner {
                ...Tibber::Graphql::Fragments::OwnerFragment
              }
              meteringPointData {
                consumptionEan
                gridCompany
                gridAreaCode
                priceAreaCode
                productionEan
                energyTaxType
                vatType
                estimatedAnnualConsumption
              }
              currentSubscription {
                id
                validFrom
                validTo
                status
              }
              features {
                realTimeConsumptionEnabled
              }
            }
          }
        }
      GRAPHQL

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
    end
  end
end
