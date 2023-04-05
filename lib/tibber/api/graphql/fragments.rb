# frozen_string_literal: true

module Tibber
  module Api
    module Graphql
      module Fragments
        AddressFragment = Graphql.validation_client.parse <<-'GRAPHQL'
          fragment on Address {
            address1
            address2
            address3
            city
            postalCode
            country
            latitude
            longitude
          }
        GRAPHQL

        OwnerFragment = Graphql.validation_client.parse <<-'GRAPHQL'
          fragment on LegalEntity {
            id
            firstName
            isCompany
            name
            middleName
            lastName
            organizationNo
            language
            contactInfo {
              email
              mobile
            }
          }
        GRAPHQL

        ConsumptionFragment = Graphql.validation_client.parse <<-'GRAPHQL'
          fragment on Consumption {
            from
            to
            cost
            currency
            unitPrice
            unitPriceVAT
            consumption
            consumptionUnit
          }
        GRAPHQL
      end
    end
  end
end
