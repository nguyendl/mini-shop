require 'services/spec_setup'
require 'spec/services/shared/errors'

describe Services::Inventory::Discounts do
  describe 'get /discounts' do
    let(:method) { :get }
    let(:path) { '/discounts' }

    before :each do
      FactoryGirl.create :discount
    end

    it 'returns all discounts' do
      send_request
      expect_status(200)
      expect_response(Discount.all.map do |discount|
        DiscountSerializer.new(discount)
      end.to_json)
    end
  end

  describe 'post /discounts' do
    let(:method) { :post }
    let(:path) { '/discounts' }

    context 'invalid parameters' do
      let(:params) { {} }

      include_examples 'bad request'

      it 'does not create new discount' do
        expect { send_request }.to_not change { Discount.count }
      end
    end

    context 'valid parameters' do
      let(:params) { { discount: FactoryGirl.build(:discount).attributes } }

      it 'creates new discount' do
        expect { send_request }.to change { Discount.count }.by(1)
        expect_status(200)
        expect_response(DiscountSerializer.new(Discount.last).to_json)
      end
    end
  end

  describe 'put /discounts/:id' do
    let(:method) { :put }
    let(:path) { "/discounts/#{id}" }

    include_examples 'invalid id'

    context 'valid id' do
      let(:discount) { FactoryGirl.create :discount }
      let(:id) { discount.id }

      context 'invalid parameters' do
        let(:params) { { discount: { rate: nil } } }

        include_examples 'bad request'

        it 'does not update the discount' do
          expect { send_request }.to_not change { discount.reload.attributes }
        end
      end

      context 'valid parameters' do
        let(:params) { { discount: { name: rand_str } } }

        it 'updates the existing discount' do
          expect { send_request }.to change { discount.reload.attributes }
          expect_status(200)
          expect_response(DiscountSerializer.new(discount).to_json)
        end
      end
    end
  end
end
