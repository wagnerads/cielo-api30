module Cielo
  module API30
    class ReplyData < OptionTemplate
      attr_accessor :address_info_code,
                    :factor_code,
                    :score,
                    :host_severity,
                    :hot_list_info_code,
                    :internet_info_code,
                    :score_model_used,
                    :case_priority,
                    :provider_transaction_id,
                    :velocity_info_code,
                    :identity_info_code,
                    :phone_info_code,
                    :suspicious_info_code

      def self.from_json(data)
        return if data.nil?

        reply_data = new()
        reply_data.address_info_code = data['AddressInfoCode']
        reply_data.factor_code = data['FactorCode']
        reply_data.score = data['Score']
        reply_data.host_severity = data['HostSeverity']
        reply_data.hot_list_info_code = data['HotListInfoCode']
        reply_data.internet_info_code = data['InternetInfoCode']
        reply_data.score_model_used = data['ScoreModelUsed']
        reply_data.case_priority = data['CasePriority']
        reply_data.provider_transaction_id = data['ProviderTransactionId']
        reply_data.velocity_info_code = data['VelocityInfoCode']
        reply_data.identity_info_code = data['IdentityInfoCode']
        reply_data.phone_info_code = data['PhoneInfoCode']
        reply_data.suspicious_info_code = data['SuspiciousInfoCode']

        reply_data
      end

      def as_json(_options = {})
        hash_compact!(
          AddressInfoCode: @address_info_code,
          FactorCode: @factor_code,
          Score: @score,
          HostSeverity: @host_severity,
          HotListInfoCode: @hot_list_info_code,
          InternetInfoCode: @internet_info_code,
          ScoreModelUsed: @score_model_used,
          CasePriority: @case_priority,
          ProviderTransactionId: @provider_transaction_id,
          VelocityInfoCode: @velocity_info_code,
          IdentityInfoCode: @identity_info_code,
          PhoneInfoCode: @phone_info_code,
          SuspiciousInfoCode: @suspicious_info_code
        )
    end
  end
end
