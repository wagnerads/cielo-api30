module Cielo
  module API30
    # Customer's address.
    #
    # @attr [String] street the customer's address
    # @attr [String] number the customer's address number
    # @attr [String] complement any complement of customer's address
    # @attr [String] zip_code the zip code of customer's address
    # @attr [String] city the city of customer's address
    # @attr [String] state the state of customer's address
    # @attr [String] country the country of customer's address
    class Address < OptionTemplate
      attr_accessor :street,
                    :number,
                    :complement,
                    :zip_code,
                    :city,
                    :state,
                    :country,
                    :district

      def self.from_json(data)
        return if data.nil?

        address = new
        address.street = data['Street']
        address.number = data['Number']
        address.complement = data['Complement']
        address.zip_code = data['ZipCode']
        address.city = data['City']
        address.state = data['State']
        address.country = data['Country']
        address.district = data['District']
        address
      end

      def as_json(_options = {})
        hash_compact!(
          Street: @street,
          Number: @number,
          Complement: @complement,
          ZipCode: @zip_code,
          City: @city,
          State: @state,
          Country: @country,
          District: @district
        )
      end
    end
  end
end
