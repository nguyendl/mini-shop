require 'models/spec_setup'
require 'spec/models/shared/committable'

describe Purchase do

  let(:orders) { model.orders }
  let(:order) { orders.sample }
  let(:model_args) { [:purchase, :orders] }
  let(:item) { FactoryGirl.build :storefront_item }

  it_behaves_like 'committable model'

  it { should have_readonly_attribute(:user_id) }

  it { should have_many(:orders) }
  it { should belong_to(:payment_method) }
  it { should belong_to(:billing_address).class_name('Address') }
  it { should belong_to(:shipping_address).class_name('Address') }
  it { should belong_to(:payment).class_name('Transaction') }
  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }

  context 'pending' do
    let(:subject) { model }

    it { should be_pending }
    it { should_not validate_presence_of(:payment_method) }
    it { should_not validate_presence_of(:billing_address) }
    it { should_not validate_presence_of(:shipping_address) }
    it { should validate_uniqueness_of(:committed).scoped_to(:user_id) }
  end

  context 'committed' do
    let :subject do
      model.commit!
      model
    end

    it { should be_committed }
    it { should validate_presence_of(:payment_method) }
    it { should validate_presence_of(:billing_address) }
    it { should validate_presence_of(:shipping_address) }
  end

  describe '#normalize!' do
    it 'sets the order currency to payment method currency' do
      expect(order).to receive(:currency=).with(model.payment_method_currency)
      expect(order).to receive(:save!)
      model.normalize!
    end
  end

  describe '#commit!' do
    it 'calls #normalize!' do
      expect(model).to receive(:normalize!)
      model.commit!
    end
  end

  describe '#payment_method_currency' do
    it 'delegates to #payment_method' do
      expect(model.payment_method_currency).to eq(model.payment_method.currency)
    end
  end

  describe '.pending_purchase' do
    before :each do
      user.save!
    end

    def pending_count
      described_class.where(user_id: user.id).pending.count
    end

    it 'finds or create the pending purchase' do
      change = pending_count < 1 ? 1 : 0
      expect { described_class.pending_purchase(user) }.to change { pending_count }.by(change)
      expect(described_class.pending_purchase(user)).to be_pending
    end
  end

  describe '#add_or_update' do
    let(:currency) { FactoryGirl.build :eur }

    context 'pending' do
      before :each do
        expect(orders).to receive(:add_or_update).with(
          item,
          qty: qty,
          acc: false
        ).and_yield(order)
        expect(model).to receive(:reload)
      end

      it 'adds or updates order' do
        model.add_or_update(item, currency, qty)
      end

      it 'changes the order currency' do
        expect { model.add_or_update(item, currency, qty) }.to change { order.currency }.to(currency)
      end
    end

    context 'committed' do
      it 'does not add or update item' do
        model.commit!
        expect(orders).to_not receive(:add_or_update)
        expect(model).to_not receive(:reload)
        model.add_or_update(item, currency, qty)
      end
    end
  end

  describe '#remove' do
    context 'pending' do
      before :each do
        expect(orders).to receive(:retrieve).with(item).and_yield(order)
        expect(model).to receive(:reload)
      end

      it 'retrieves the item' do
        model.remove(item)
      end

      it 'removes the item' do
        expect { model.remove(item) }.to change { order.deleted? }.to(true)
      end
    end

    context 'committed' do
      it 'does not remove the item' do
        model.commit!
        expect(orders).to_not receive(:retrieve)
        expect(model).to_not receive(:reload)
        model.remove(item)
      end
    end
  end

  describe '#amount' do
    it 'sums order amount' do
      total_amount = model.orders.reduce(BigDecimal('0.0')) do |a, e|
        a += e.amount(currency)
      end
      expect(model.amount(currency)).to eq(total_amount)
    end
  end

  describe '#tax' do
    it 'sums order tax' do
      total_tax = model.orders.reduce(BigDecimal('0.0')) do |a, e|
        a += e.tax(currency)
      end
      expect(model.tax(currency)).to eq(total_tax)
    end
  end

  describe '#total' do
    it 'sums order total' do
      total = model.orders.reduce(BigDecimal('0.0')) do |a, e|
        a += e.total(currency)
      end
      expect(model.total(currency)).to eq(total)
    end
  end

  describe '#make_payment!' do
    context 'pending' do
      it 'does not do anything' do
        expect { model.send(:make_payment!) }.to_not change { model.payment }
      end
    end

    context 'committed' do
      before :each do
        model.save!
        model.commit!
      end

      it 'creates new payment' do
        expect { model.send(:make_payment!) }.to change { model.payment }
        expect(model.payment).to be_present
      end

      it 'sets correct information' do
        model.send(:make_payment!)
        expect(model.payment.user).to eq(model.user)
        expect(model.payment.amount).to eq(model.total)
        expect(model.payment.currency).to eq(model.payment_method_currency)
        expect(model.payment.payment_method).to eq(model.payment_method)
        expect(model.payment.billing_address).to eq(model.billing_address)
      end

      it 'does not create a new payment' do
        model.send(:make_payment!)
        expect(model.payment).to eq(model.send(:make_payment!))
      end
    end
  end

  describe '#transactions' do
    it 'returns all related transactions' do
      expect(model.transactions).to eq([model.orders.map(&:refund), model.payment].flatten)
    end
  end

  describe 'fulfillment methods' do
    let(:transaction) do
      FactoryGirl.build :transaction,
                        user: model.user,
                        amount: model.total,
                        currency: model.payment_method_currency,
                        payment_method: model.payment_method,
                        billing_address: model.billing_address
    end

    before :each do
      model.stub(:transactions).and_return([transaction])
    end

    shared_examples 'does not do anything' do
      it 'does not do anything' do
        expect(order).to_not receive(process_method)
        expect(transaction).to_not receive(:commit!)
        expect(model).to_not receive(mark_method)
        expect(model.send(method)).to be_nil
      end
    end

    shared_examples 'status false' do
      context 'status false' do
        before :each do
          model.stub(status_method).and_return(false)
        end

        include_examples 'does not do anything'
      end
    end

    shared_examples 'pending' do
      context 'pending' do
        before :each do
          model.stub(:committed?).and_return(false)
        end

        include_examples 'does not do anything'
      end
    end

    describe '#prepare!' do
      let(:method) { :prepare! }
      let(:process_method) { :prepare! }
      let(:status_method) { :unmarked? }
      let(:check_method) { :prepared? }
      let(:mark_method) { :mark_prepared! }

      before :each do
        model.stub(:committed?).and_return(true)
        model.stub(status_method).and_return(true)
        model.payment_method.stub(:enough?).with(model.total).and_return(true)
      end

      include_examples 'status false'
      include_examples 'pending'

      context 'insufficient balance' do
        before :each do
          model.payment_method.stub(:enough?).with(model.total).and_return(false)
        end

        include_examples 'does not do anything'
      end

      context 'ready' do
        it 'processes, marks status, and returns' do
          expect(model).to receive(:make_payment!)
          expect(order).to receive(process_method)
          expect(model).to receive(mark_method)
          expect(model.send(method)).to eq(model.send(check_method))
        end
      end
    end

    describe '#fulfill!' do
      let(:method) { :fulfill! }
      let(:process_method) { :fulfill! }
      let(:status_method) { :prepared? }
      let(:check_method) { :fulfilled? }
      let(:mark_method) { :mark_fulfilled! }

      before :each do
        model.stub(:committed?).and_return(true)
        model.stub(status_method).and_return(true)
      end

      include_examples 'status false'
      include_examples 'pending'

      context 'ready' do
        it 'processes, marks status, and returns' do
          expect(order).to receive(process_method)
          expect(transaction).to receive(:commit!)
          expect(model).to receive(mark_method)
          expect(model.send(method)).to eq(model.send(check_method))
        end
      end
    end

    describe '#reverse!' do
      let(:method) { :reverse! }
      let(:process_method) { :reverse! }
      let(:status_method) { :fulfilled? }
      let(:check_method) { :reversed? }
      let(:mark_method) { :mark_reversed! }

      before :each do
        model.stub(:committed?).and_return(true)
        model.stub(status_method).and_return(true)
      end

      include_examples 'status false'
      include_examples 'pending'

      context 'ready' do
        it 'processes, marks status, and returns' do
          expect(order).to receive(process_method)
          expect(model).to receive(mark_method)
          expect(model.send(method)).to eq(model.send(check_method))
        end
      end
    end
  end
end
