module BackendClient
  class Discount
    include APIResource
    include APIModel
    include DefaultAll
    include DefaultFind
    include DefaultCreate
    include DefaultUpdate

    def self.build_attributes(hash = {})
      super do |discount|
        discount.current_rate = BigDecimal.new(discount.current_rate)
        discount.rate = BigDecimal.new(discount.rate)
        discount.start_at = DateTime.parse(discount.start_at) if discount.start_at.present?
        discount.end_at = DateTime.parse(discount.end_at) if discount.end_at.present?
      end
    end
  end
end
