module Cielo
  module API30
    class Cart < OptionTemplate
      attr_accessor :items

      def initialize(items)
        super
        @items = items
      end

      def self.from_json(data)
        return if data.nil?

        new(data['Items'].map { |i| CartItem.from_json(i) })
      end

      def as_json(options = {})
        hash_compact!(
          Items: @items&.as_json(options)
        )
      end
    end
  end
end
