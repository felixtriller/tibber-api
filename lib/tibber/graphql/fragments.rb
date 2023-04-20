# frozen_string_literal: true

module Tibber
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
    end
  end
end
