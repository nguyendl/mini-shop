require 'services/base'

module Services
  module Inventory
    class Currencies < Services::Base
      get '/' do
        currencies = paginate(Currency).all
        respond_with(currencies.map do |currency|
          CurrencySerializer.new(currency)
        end)
      end

      post '/' do
        currency = Currency.new(params[:currency])
        currency.save!
        respond_with(CurrencySerializer.new(currency))
      end
    end
  end
end
