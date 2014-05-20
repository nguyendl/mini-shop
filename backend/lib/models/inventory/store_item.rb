require 'models/shared/item_resource'
require 'models/shared/orderable'
require 'models/shared/activable'

class StoreItem < ActiveRecord::Base
  include ItemResource
  include Orderable
  include Itemable
  include Activable

  belongs_to :price

  validates :name, presence: true
  validates :price, presence: true
  validates :item_type, inclusion: { in: %w{ Bundle DigitalItem PhysicalItem } }

  delegate :amount, to: :price
  delegate :discounted?, to: :price
  delegate :fulfill!, to: :item
  delegate :reverse!, to: :item
  delegate :title, to: :item, allow_nil: true
  delegate :description, to: :item, allow_nil: true

  def available?
    super && item.available?
  end
end