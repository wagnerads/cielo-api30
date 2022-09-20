module Cielo
  module API30
    class ExternalAuthentication < OptionTemplate
      attr_accessor :cavv,
                    :xid,
                    :eci,
                    :version,
                    :reference_id

      def initialize(cavv: nil, xid: nil, eci: nil, version: nil, reference_id: nil)
        @cavv = cavv
        @xid = xid
        @eci = eci
        @version = version
        @reference_id = reference_id
      end

      def self.from_json(data)
        return if data.nil?

        new(cavv: data['cavv'], xid: data['xid'], eci: data['eci'], version: data['version'], reference_id: data['reference_id'])
      end

      def as_json(options = {})
        hash_compact!(
          Cavv: @cavv,
          Xid: @xid,
          Eci: @eci,
          Version: @version,
          ReferenceId: @reference_id
        )
      end
    end
  end
end
