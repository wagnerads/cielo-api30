module Cielo
  module API30
    class FraudAnalysisShipping < OptionTemplate
      METHOD_SAME_DAY = 'SameDay'
      METHOD_ONE_DAY = 'OneDay'
      METHOD_TWO_DAY = 'TwoDay'
      METHOD_THREE_DAY = 'ThreeDay'
      METHOD_LOW_COST = 'LowCost'
      METHOD_PICKUP = 'Pickup'
      METHOD_OTHER = 'Other'
      METHOD_NONE = 'None'

      attr_accessor :addressee,
                    :method,
                    :phone

      def initialize(addressee: nil, method: FraudAnalysisShipping::METHOD_NONE, phone: nil)
        @addressee = addressee
        @method = method
        @phone = phone
      end

      def self.from_json(data)
        return if data.nil?

        new(addressee: data['Addressee'], method: data['Method'], phone: data['Phone'])
      end

      def as_json(_options = {})
        hash_compact!(
          Addressee: @addressee,
          Method: @method,
          Phone: @phone
        )
      end
    end
  end
end
