module Cielo
  module API30
    class RecurrentPayment < OptionTemplate
      INTERVAL_MONTHLY = 'Monthly'
      INTERVAL_BIMONTHLY = 'Bimonthly'
      INTERVAL_QUARTERLY = 'Quarterly'
      INTERVAL_SEMIANNUAL = 'SemiAnnual'
      INTERVAL_ANNUAL = 'Annual'

      attr_accessor :authorize_now,
                    :start_date,
                    :end_date,
                    :interval,
                    :recurrent_payment_id,
                    :next_recurrency,
                    :link

      def initialize(authorize_now: true)
        super
        @authorize_now = authorize_now
      end

      def self.from_json(data)
        return if data.nil?

        recurrent_payment = new(data['AuthorizeNow'])
        recurrent_payment.start_date = data['StartDate']
        recurrent_payment.end_date = data['EndDate']
        recurrent_payment.interval = data['Interval']
        recurrent_payment.recurrent_payment_id = data['RecurrentPaymentId']
        recurrent_payment.next_recurrency = data['NextRecurrency']
        recurrent_payment.link = data['Link']
        recurrent_payment
      end

      def as_json(_options = {})
        hash_compact!(
          AuthorizeNow: @authorize_now,
          StartDate: @start_date,
          EndDate: @end_date,
          Interval: @interval
        )
      end
    end
  end
end
