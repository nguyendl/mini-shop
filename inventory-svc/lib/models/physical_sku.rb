class PhysicalSku < ActiveRecord::Base
  include SkuResource

  attr_accessible :quantity

  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def available?
    !self.removed? && self.active? && self.quantity > 0
  end

end