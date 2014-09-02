module Inventory
  class PricesController < ApplicationController
    def index
      @prices = Price.all
      @pricepoints = Pricepoint.all
      @discounts = Discount.all
    end

    def create
      @price = Price.create(
        params.require(:price).permit(:name, :pricepoint_id, :discount_id)
      )
      go_back
    end

    def update
      @price = update_resource(
        Price.find(id),
        params.require(:price).permit(:name, :pricepoint_id, :discount_id)
      )
      go_back
    end
  end
end
