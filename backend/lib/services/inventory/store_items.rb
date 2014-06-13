require 'services/base'
require 'models/serializers/inventory'

module Services
  module Inventory
    class StoreItems < Services::Base
      get '/store_items' do
        process_request do
          store_items = StoreItem.all
          respond_with(store_items.map do |item|
            StoreItemSerializer.new(item)
          end)
        end
      end

      post '/store_items' do
        process_request do
          store_item = StoreItem.new(params[:store_item])
          store_item.save!
          respond_with(StoreItemSerializer.new(store_item))
        end
      end

      put '/store_items/:id' do
        process_request do
          store_item = StoreItem.find(params[:id])
          store_item.update_attributes!(params[:store_item])
          respond_with(StoreItemSerializer.new(store_item))
        end
      end

      delete '/store_items/:id' do
        process_request do
          store_item = StoreItem.find(params[:id])
          store_item.delete!
          respond_with(StoreItemSerializer.new(store_item))
        end
      end
    end
  end
end
