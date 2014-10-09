module Shopping
  class PurchasesController < ApplicationController
    def show
      @purchase = Purchase.find(id)
      @payment_method = @purchase.payment_method
      @shipping_address = @purchase.shipping_address
      @orders = @purchase.orders
      @payment_transaction = @purchase.payment_transaction
      @user = @purchase.user
    end

    def return
      @purchase = Purchase.find(id)
      @purchase.return!
      flash[:success] = 'Purchase refunded successfuly' and go_back
    end
  end
end
