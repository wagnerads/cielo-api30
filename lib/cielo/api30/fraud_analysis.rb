module Cielo
  module API30
    class FraudAnalysis < OptionTemplate
      SEQUENCE_AUTORIZE_FIRST = 'AuthorizeFirst'

      SEQUENCE_CRITERIA = 'OnSuccess'

      attr_accessor :provider,
                    :sequence,
                    :sequence_criteria,
                    :total_order_amount,
                    :finger_print_id,
                    :browser,
                    :cart,
                    :status,
                    :status_description,
                    :transaction_amount,
                    :shipping,
                    :merchant_defined_fields,
                    :fraud_analysis_reason_code,
                    :id,
                    :reply_data,
                    :void_on_high_risk

      def initialize(total_order_amount, finger_print_id: nil, provider: 'cybersource', sequence: SEQUENCE_AUTORIZE_FIRST, sequence_criteria: SEQUENCE_CRITERIA)
        super
        @provider = provider
        @sequence = sequence
        @sequence_criteria = sequence_criteria
        @total_order_amount = total_order_amount
        @transaction_amount = total_order_amount
        @finger_print_id = finger_print_id
        @merchant_defined_fields = []
      end

      def self.from_json(data)
        return if data.nil?

        fraud_analysis = new(data['TotalOrderAmount'], provider: data['Provider'], sequence: data['Sequence'], sequence_criteria: data['SequenceCriteria'])
        fraud_analysis.finger_print_id = data['FingerPrintId']
        fraud_analysis.browser = Browser.from_json(data['Browser'])
        fraud_analysis.cart = Cart.from_json(data['Cart'])
        fraud_analysis.status = data['Status']
        fraud_analysis.status_description = data['StatusDescription']
        fraud_analysis.transaction_amount = data['TransactionAmount']
        fraud_analysis.shipping = FraudAnalysisShipping.from_json(data['Shipping'])
        fraud_analysis.merchant_defined_fields = data['MerchantDefinedFields'].map { |i| MerchantDefinedFields.from_json(i) }
        fraud_analysis.fraud_analysis_reason_code = data['FraudAnalysisReasonCode']
        fraud_analysis.id = data['Id']
        fraud_analysis.reply_data = ReplyData.from_json(data['ReplyData'])
        fraud_analysis.void_on_high_risk = data['VoidOnHighRisk']

        fraud_analysis
      end

      def as_json(options = {})
        hash_compact!(
          Provider: @provider,
          Sequence: @sequence,
          SequenceCriteria: @sequence_criteria,
          TotalOrderAmount: @total_order_amount,
          TransactionAmount: @transaction_amount,
          FingerPrintId: @finger_print_id,
          Browser: @browser&.as_json(options),
          Cart: @cart&.as_json(options),
          Shipping: @shipping&.as_json(options),
          MerchantDefinedFields: @merchant_defined_fields&.as_json(options),
          FraudAnalysisReasonCode: @fraud_analysis_reason_code,
          StatusDescription: @status_description,
          Status: @status,
          Id: @id,
          ReplyData: @reply_data&.as_json(options),
          VoidOnHighRisk: @void_on_high_risk
        )
      end
    end
  end
end
