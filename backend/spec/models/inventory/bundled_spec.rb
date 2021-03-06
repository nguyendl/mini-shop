require 'models/spec_setup'
require 'spec/models/shared/item_combinable'

describe Bundled do
  it_behaves_like 'item combinable model'
end

describe Bundled do
  it { should have_readonly_attribute(:bundle_id) }

  it { should belong_to(:bundle).inverse_of(:bundleds) }

  it { should validate_presence_of(:bundle) }

  it { should ensure_inclusion_of(:item_type).in_array(%w(DigitalItem PhysicalItem)) }
end
