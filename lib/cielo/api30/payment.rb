module Cielo
  module API30
    class Payment < OptionTemplate
      PAYMENTTYPE_CREDITCARD = 'CreditCard'
      PAYMENTTYPE_DEBITCARD = 'DebitCard'
      PAYMENTTYPE_ELECTRONIC_TRANSFER = 'ElectronicTransfer'
      PAYMENTTYPE_BOLETO = 'Boleto'

      PROVIDER_BRADESCO = 'Bradesco'
      PROVIDER_BANCO_DO_BRASIL = 'BancoDoBrasil'
      PROVIDER_SIMULADO = 'Simulado'

      TRANSACAO_CAPTURADA = '6'

      attr_accessor :service_tax_amount,
                    :installments,
                    :interest,
                    :capture,
                    :authenticate,
                    :recurrent,
                    :recurrent_payment,
                    :credit_card,
                    :proof_of_sale,
                    :authorization_code,
                    :soft_descriptor,
                    :return_url,
                    :provider,
                    :payment_id,
                    :tid,
                    :type,
                    :amount,
                    :received_date,
                    :captured_amount,
                    :captured_date,
                    :currency,
                    :country,
                    :return_code,
                    :return_message,
                    :status,
                    :links,
                    :extra_data_collection,
                    :expiration_date,
                    :url,
                    :number,
                    :bar_code_number,
                    :digitable_line,
                    :address,
                    :return_info,
                    :fraud_analysis,
                    :external_authentication,
                    :voided_amount

      def initialize(amount, installments: 1)
        @amount = amount
        @installments = installments
      end

      def self.from_json(data)
        return if data.nil?

        payment = new(data['Amount'])

        payment.service_tax_amount = data['ServiceTaxAmount']
        payment.installments = data['Installments']
        payment.interest = data['Interest']
        payment.capture = data['Capture']
        payment.authenticate = data['Authenticate']
        payment.recurrent = data['Recurrent']
        payment.recurrent_payment = RecurrentPayment.from_json(data['RecurrentPayment'])
        payment.credit_card = CreditCard.from_json(data['CreditCard'])
        payment.proof_of_sale = data['ProofOfSale']
        payment.authorization_code = data['AuthorizationCode']
        payment.soft_descriptor = data['SoftDescriptor']
        payment.return_url = data['ReturnUrl']
        payment.provider = data['Provider']
        payment.payment_id = data['PaymentId']
        payment.tid = data['Tid']
        payment.type = data['Type']
        payment.received_date = data['ReceivedDate']
        payment.captured_amount = data['CapturedAmount']
        payment.captured_date = data['CapturedDate']
        payment.currency = data['Currency']
        payment.country = data['Country']
        payment.return_code = data['ReturnCode']
        payment.return_message = data['ReturnMessage']
        payment.status = data['Status']

        payment.links = data['Links']
        payment.extra_data_collection = data['ExtraDataCollection']

        payment.expiration_date = data['ExpirationDate']
        payment.url = data['Url']
        payment.number = data['Number']
        payment.bar_code_number = data['BarCodeNumber']
        payment.digitable_line = data['DigitableLine']
        payment.address = data['Address']
        payment.fraud_analysis = FraudAnalysis.from_json(data['FraudAnalysis'])
        payment.return_info = ReturnInfo.new(payment.return_code)
        payment.external_authentication = ExternalAuthentication.from_json(data['ExternalAuthentication'])

        payment
      end

      def success?
        [
          Payment::Status::AUTHORIZED,
          Payment::Status::PAYMENT_CONFIRMED
        ].include?(status)
      end

      def capture_success?
        return_code == TRANSACAO_CAPTURADA
      end

      def void_success?
        [
          Payment::Status::VOIDED
        ].include?(status)
      end

      def as_json(options = {})
        hash_compact!(
          ServiceTaxAmount: @service_tax_amount,
          Installments: @installments,
          Interest: @interest,
          Capture: @capture,
          Authenticate: @authenticate,
          Recurrent: @recurrent,
          RecurrentPayment: @recurrent_payment&.as_json(options),
          CreditCard: @credit_card&.as_json(options),
          SoftDescriptor: @soft_descriptor,
          ReturnUrl: @return_url,
          Provider: @provider,
          Type: @type,
          Amount: @amount,
          Currency: @currency,
          Country: @country,
          Number: @number,
          BarCodeNumber: @bar_code_number,
          DigitableLine: @digitable_line,
          Address: @address,
          ReturnInfo: @return_info&.as_json(options),
          FraudAnalysis: @fraud_analysis&.as_json(options)
        )
      end
    end
  end
end
