require 'lib/base'

module BackendClient
  class Discount < Base
    include DefaultAll
    include DefaultFind
    include DefaultCreate
    include DefaultUpdate

    def self.instantiate(hash = {})
      super do |discount|
        discount.rate = BigDecimal.new(discount.rate)
        discount.start_at = DateTime.parse(discount.start_at) if discount.start_at.present?
        discount.end_at = DateTime.parse(discount.end_at) if discount.end_at.present?
      end
    end
  end
end
