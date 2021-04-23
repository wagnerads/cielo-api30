module Cielo
  module API30
    # Customer data
    #
    # @attr [String] name Customer name
    # @attr [String] email Customer email
    # @attr [String] birthDate Customer's birth date
    # @attr [String] identity Customer id
    # @attr [String] identityType The type of customer id
    # @attr [Address] address Customer's address
    # @attr [Address] deliveryAddress The delivery address
    class Customer < OptionTemplate
      attr_accessor :name,
                    :email,
                    :birth_date,
                    :identity,
                    :identity_type,
                    :address,
                    :delivery_address,
                    :billing_address,
                    :phone

      def initialize(name)
        super
        @name = name
      end

      def self.from_json(data)
        return if data.nil?

        customer = new(data['Name'])
        customer.email = data['Email']
        customer.birth_date = data['BirthDate']
        customer.identity = data['Identity']
        customer.identity_type = data['IdentityType']
        customer.address = Address.from_json(data['Address'])
        customer.delivery_address = Address.from_json(data['DeliveryAddress'])
        customer.billing_address = Address.from_json(data['BillingAddress'])
        customer.phone = data['Phone']

        customer
      end

      def as_json(options = {})
        hash_compact!(
          Name: @name,
          Email: @email,
          BirthDate: @birth_date,
          Identity: @identity,
          IdentityType: @identity_type,
          Address: @address&.as_json(options),
          DeliveryAddress: @delivery_address&.as_json(options),
          BillingAddress: @billing_address&.as_json(options),
          Phone: @phone
        )
      end
    end
  end
end
