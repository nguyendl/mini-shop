module BackendClient
  class PaymentMethod
    include APIResource
    include APIModel
    include DefaultUpdate

    def self.build_attributes(hash = {})
      super do |payment_method|
        payment_method.balance = BigDecimal.new(payment_method.balance)
      end
    end
  end
end
