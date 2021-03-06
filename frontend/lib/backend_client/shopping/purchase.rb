module BackendClient
  class Purchase
    include APIResource
    include APIModel
    include DefaultFind
    include DefaultUpdate

    def self.build_attributes(hash = {})
      super do |purchase|
        purchase.payment_method = PaymentMethod.instantiate(purchase.payment_method)
        purchase.shipping_address = Address.instantiate(purchase.shipping_address)
        purchase.payment_transaction = PaymentTransaction.instantiate(purchase.payment_transaction)
        purchase.orders.map! { |order| Order.instantiate(order) }
        purchase.currency = Currency.instantiate(purchase.currency)
        purchase.amount = BigDecimal.new(purchase.amount)
        purchase.tax = BigDecimal.new(purchase.tax)
        purchase.total = BigDecimal.new(purchase.total)
        purchase.paid_amount = BigDecimal.new(purchase.paid_amount)
        purchase.refund_amount = BigDecimal.new(purchase.refund_amount)
        purchase.charge_amount = BigDecimal.new(purchase.charge_amount)
        purchase.committed_at = DateTime.parse(purchase.committed_at) if purchase.committed_at.present?
      end
    end

    def user
      @cache[:user] ||= User.find(user_id)
    end

    def add_or_update_order(order = {})
      if order.present?
        load!(
          self.class.post(
            path: "/#{id}/orders",
            payload: Order.params(order)
          )
        )
        orders.last
      end
    end

    def delete_order(order_id)
      load!(
        self.class.delete(
          path: "/#{id}/orders/#{order_id}"
        )
      )
      orders.count
    end

    def submit!
      load!(
        self.class.put(
          path: "/#{id}/submit"
        )
      )
    end

    def return!
      load!(
        self.class.put(
          path: "/#{id}/return"
        )
      )
    end

    def return_order(order_id)
      load!(
        self.class.put(
          path: "/#{id}/orders/#{order_id}/return"
        )
      )
      orders.find { |order| order.id == order_id }
    end
  end
end
