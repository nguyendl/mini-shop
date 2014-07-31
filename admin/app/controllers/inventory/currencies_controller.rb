module Inventory
  class CurrenciesController < ApplicationController
    def index
      @currencies = resource_class.all(pagination)
      render nothing: true
    end

    def create
      scoped_params(:currencies).each do |currency|
        resource_class.create(
          currency.permit(:code, :sign)
        )
      end
      render nothing: true
    end

    private

    def set_resource_class
      @resource_class = BackendClient::Currency
    end
  end
end