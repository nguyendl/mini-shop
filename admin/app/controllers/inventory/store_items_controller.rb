module Inventory
  class StoreItemsController < ApplicationController
    def index
      @store_items = StoreItem.all
      @physical_items = PhysicalItem.all
      @digital_items = DigitalItem.all
      @bundles = Bundle.all
      @prices = Price.all
    end

    def create
      @store_item = StoreItem.create(
        params.require(:store_item).permit(:name, :price_id).merge(
          Yajl::Parser.parse params.require(:store_item).require(:item)
        )
      )
      flash[:success] = 'Store item created successfully' and go_back
    end

    def update
      @store_item = update_resource(
        StoreItem.find(id),
        params.require(:store_item).permit(:name, :price_id)
      )
      flash[:success] = 'Store item updated successfully' and go_back
    end

    def destroy
      @store_item = StoreItem.find(id)
      @store_item.delete!
      flash[:success] = 'Store item deleted successfully' and go_back
    end
  end
end
