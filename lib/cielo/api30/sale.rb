module Cielo
  module API30
    class Sale < OptionTemplate
      attr_accessor :merchant_order_id,
                    :customer,
                    :payment

      def initialize(merchant_order_id)
        @merchant_order_id = merchant_order_id
      end

      def self.from_json(data)
        return if data.nil?

        sale = new(data['MerchantOrderId'])
        sale.customer = Customer.from_json(data['Customer'])
        sale.payment = Payment.from_json(data['Payment'])
        sale
      end

      def as_json(options = {})
        hash_compact!(
          MerchantOrderId: @merchant_order_id,
          Customer: @customer&.as_json(options),
          Payment: @payment&.as_json(options)
        )
      end
    end
  end
end
