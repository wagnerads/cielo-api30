module Cielo
  module API30
    class CartItem < OptionTemplate
      attr_accessor :name,
                    :quantity,
                    :sku,
                    :unit_price

      def initialize(name, quantity, sku, unit_price)
        @name = name
        @quantity = quantity
        @sku = sku
        @unit_price = unit_price
      end

      def to_json(*options)
        as_json(*options)&.to_json(*options)
      end

      def self.from_json(data)
        return if data.nil?

        new(data['Name'], data['Quantity'], data['Sku'], data['UnitPrice'])
      end

      def as_json(_options = {})
        hash_compact!(
          Name: @name,
          Quantity: @quantity,
          Sku: @sku,
          UnitPrice: @unit_price
        )
      end
    end
  end
end
