require "spec_helper"

describe PricepointPrice do

  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:pricepoint) }
  it { should validate_presence_of(:currency) }

  it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  it { should validate_uniqueness_of(:currency_id).scoped_to(:pricepoint_id) }
  
end