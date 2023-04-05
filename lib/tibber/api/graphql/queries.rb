# frozen_string_literal: true

module Tibber
  module Api
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
                  ...Tibber::Api::Graphql::Fragments::AddressFragment
                }
                owner {
                  ...Tibber::Api::Graphql::Fragments::OwnerFragment
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
          query($id: ID!, $resolution: EnergyResolution!, $num: Int!) {
            viewer {
              home(id: $id) {
                consumption(resolution: $resolution, last: $num) {
                  nodes {
                    ...Tibber::Api::Graphql::Fragments::ConsumptionFragment
                  }
                }
              }
            }
          }
        GRAPHQL

        ConsumptionsQuery = Graphql.validation_client.parse <<-'GRAPHQL'
          query($resolution: EnergyResolution!, $num: Int!) {
            viewer {
              homes {
                consumption(resolution: $resolution, last: $num) {
                  nodes {
                    ...Tibber::Api::Graphql::Fragments::ConsumptionFragment
                  }
                }
              }
            }
          }
        GRAPHQL
      end
    end
  end
end
