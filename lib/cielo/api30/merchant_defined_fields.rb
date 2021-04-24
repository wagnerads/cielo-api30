module Cielo
  module API30
    class MerchantDefinedFields < OptionTemplate
      LOGGED_USER = '1'
      NUMBER_OF_DAYS_REGISTERED = '2'
      ORDER_INSTALLMENTS_QUANTITY = '3'
      SALES_CHANNEL = '4'
      PICKUP_IN_STORE = '9'
      BUSINESS_SEGMENT = '83'
      TYPE_OF_DEVELOPMENT = '84'

      attr_accessor :id,
                    :value

      def initialize(id, value)
        super
        @id = id
        @value = value
      end

      def self.from_json(data)
        return if data.nil?

        new(data['Id'], data['Value'])
      end

      def as_json(_options = {})
        hash_compact!(
          Id: @id,
          Value: @value
        )
      end
    end
  end
end
