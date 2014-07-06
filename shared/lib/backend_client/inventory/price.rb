require 'backend_client/base'

module BackendClient
  class Price < Base
    extend DefaultAll
    extend DefaultFind
    extend DefaultCreate
    include DefaultUpdate

    def self.instantiate(hash = {})
      super do |price|
        price.pricepoint = Pricepoint.instantiate(price.pricepoint)
        price.discount = Discount.instantiate(price.discount)
      end
    end
  end
end
