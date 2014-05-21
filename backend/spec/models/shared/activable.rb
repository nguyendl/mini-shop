shared_examples 'activable model' do

  it { should_not allow_mass_assignment_of(:active) }

  context 'class' do
    let(:subject) { described_class }
    it { should respond_to(:active).with(0).argument }
    it { should respond_to(:inactive).with(0).argument }
  end

  context 'instance' do
    let(:subject) { described_class.new }
    it { should respond_to(:active).with(0).argument }
    it { should respond_to(:active=).with(1).argument }
    it { should respond_to(:active?).with(0).argument }
    it { should respond_to(:inactive?).with(0).argument }
    it { should respond_to(:activate!).with(0).argument }
    it { should respond_to(:deactivate!).with(0).argument }
  end

  context 'new record' do
    let(:model) { described_class.new }

    it 'defaults to pending' do
      expect(model).to be_active
    end
  end

  describe '#active?' do
    it 'equals #active' do
      expect(model.active?).to eq(model.active)
    end
  end

  describe '#activate!' do
    before :each do
      model.active = active
    end

    context 'active' do
      let(:active) { true }

      it 'cannot be executed' do
        expect(model.activate!).to_not be_true
      end

      it 'cannot change active status' do
        expect { model.activate! }.to_not change { model.active? }
      end
    end

    context 'inactive' do
      let(:active) { false }

      it 'can be executed' do
        expect(model.activate!).to be_true
      end

      it 'changes active status to true' do
        expect { model.activate! }.to change { model.active? }.to(!active)
      end
    end
  end

  describe '#deactivate!' do
    before :each do
      model.active = active
    end

    context 'inactive' do
      let(:active) { false }

      it 'cannot be executed' do
        expect(model.deactivate!).to_not be_true
      end

      it 'cannot change active status' do
        expect { model.deactivate! }.to_not change { model.active? }
      end
    end

    context 'active' do
      let(:active) { true }

      it 'can be executed' do
        expect(model.deactivate!).to be_true
      end

      it 'changes active status to false' do
        expect { model.deactivate! }.to change { model.active? }.to(!active)
      end
    end
  end

  describe '#inactive?' do
    it 'opposites #active?' do
      expect(model.inactive?).to eq(!model.active?)
    end
  end
end
