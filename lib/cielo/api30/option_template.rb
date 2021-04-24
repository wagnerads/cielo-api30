module Cielo
  module API30
    class OptionTemplate
      def to_json(*options)
        as_json(*options)&.to_json(*options)
      end

      def self.from_json(_data)
        raise NotImplementedError, 'subclass did not define .from_json'
      end

      def as_json(_options = {})
        raise NotImplementedError, 'subclass did not define #as_json'
      end

      protected

      def hash_compact!(data)
        data = data.reject! { |_k, v| v.nil? }
        data&.empty? ? nil : data
      end
    end
  end
end
