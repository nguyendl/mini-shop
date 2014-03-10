require "models/shared/item_resource"
require "models/shared/orderable"

class StorefrontItem < ActiveRecord::Base

  include ItemResource
  include Orderable
  include Itemable

  attr_accessible :price_id, :name

  belongs_to :price

  validates :name, presence: true
  validates :price, presence: true
  validates :item_type, inclusion: { in: %w{ BundleItem DigitalItem PhysicalItem } }

  delegate :amount, to: :price
  delegate :discounted?, to: :price
  delegate :prepare!, to: :item
  delegate :title, to: :item, allow_nil: true
  delegate :description, to: :item, allow_nil: true

  def available?
    super && item.available?
  end

end