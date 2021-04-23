module Cielo
  module API30
    class Browser < OptionTemplate
      attr_accessor :cookies_accepted,
                    :ip_address,
                    :email,
                    :browser_finger_print

      def initialize(email, ip_address, browser_finger_print, cookies_accepted: true)
        super
        @email = email
        @ip_address = ip_address
        @cookies_accepted = cookies_accepted
        @browser_finger_print = browser_finger_print
      end

      def self.from_json(data)
        return if data.nil?

        new(data['Email'], data['IpAddress'], data['BrowserFingerPrint'], cookies_accepted: data['CookiesAccepted'])
      end

      def as_json(_options = {})
        hash_compact!(
          CookiesAccepted: @cookies_accepted,
          IpAddress: @ip_address,
          Email: @email,
          BrowserFingerPrint: @browser_finger_print
        )
      end
    end
  end
end
