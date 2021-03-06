require 'services/spec_setup'

describe Services::Inventory::Pricepoints do
  describe 'get /' do
    let(:method) { :get }
    let(:path) { '/' }

    before :each do
      FactoryGirl.create :pricepoint
    end

    context 'pagination' do
      let(:scope) { Pricepoint }
      let(:serializer) { PricepointSerializer }

      include_examples 'pagination'
    end
  end

  describe 'get /:id' do
    let(:method) { :get }
    let(:path) { "/#{id}" }

    include_examples 'invalid id'

    context 'valid id' do
      let(:pricepoint) { FactoryGirl.create :pricepoint }
      let(:id) { pricepoint.id }

      it 'returns the pricepoint' do
        send_request
        expect_status(200)
        expect_response(PricepointSerializer.new(pricepoint).to_json)
      end
    end
  end

  describe 'post /' do
    let(:method) { :post }
    let(:path) { '/' }

    context 'invalid parameters' do
      let(:params) { {} }

      include_examples 'bad request'

      it 'does not create new pricepoint' do
        expect { send_request }.to_not change { Pricepoint.count }
      end
    end

    context 'valid parameters' do
      let(:params) { { pricepoint: FactoryGirl.build(:pricepoint).attributes } }

      it 'creates new pricepoint' do
        expect { send_request }.to change { Pricepoint.count }.by(1)
        expect_status(200)
        expect_response(PricepointSerializer.new(Pricepoint.last).to_json)
      end
    end
  end

  describe 'put /:id' do
    let(:method) { :put }
    let(:path) { "/#{id}" }

    include_examples 'invalid id'

    context 'valid id' do
      let(:pricepoint) { FactoryGirl.create :pricepoint }
      let(:id) { pricepoint.id }

      context 'invalid parameters' do
        let(:params) { { pricepoint: { name: nil } } }

        include_examples 'bad request'

        it 'does not update the pricepoint' do
          expect { send_request }.to_not change { pricepoint.reload.attributes }
        end
      end

      context 'valid parameters' do
        let(:params) { { pricepoint: { name: rand_str } } }

        it 'updates the pricepoint' do
          expect { send_request }.to change { pricepoint.reload.attributes }
          expect_status(200)
          expect_response(PricepointSerializer.new(pricepoint).to_json)
        end
      end
    end
  end

  describe 'post /:id/pricepoint_prices' do
    let(:method) { :post }
    let(:path) { "/#{id}/pricepoint_prices" }

    include_examples 'invalid id'

    context 'valid id' do
      let(:pricepoint) { FactoryGirl.create :pricepoint }
      let(:id) { pricepoint.id }

      context 'invalid parameters' do
        let(:params) { { pricepiont_price: { amount: nil } } }

        include_examples 'bad request'

        it 'does not create new pricepoint prices' do
          expect { send_request }.to_not change { pricepoint.pricepoint_prices.count }
        end
      end

      context 'valid parameters' do
        let :params do
          {
            pricepoint_price: FactoryGirl.build(:pricepoint_price).attributes
          }
        end

        it 'creates new pricepoint price' do
          expect { send_request }.to change { pricepoint.pricepoint_prices.count }.by(1)
          expect_status(200)
          expect_response(PricepointSerializer.new(pricepoint).to_json)
        end
      end
    end
  end
end
