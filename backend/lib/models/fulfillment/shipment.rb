class Shipment < ActiveRecord::Base

  attr_accessible :user_id, :item_type, :item_id, :quantity, :shipping_address_id

  ITEM_TYPES = [ "PhysicalItem" ]

  belongs_to :user
  belongs_to :item, polymorphic: true
  belongs_to :shipping_address, class_name: "Address"

  validates :user_id,   presence: true
  validates :item_type, presence: true
  validates :item_type, inclusion: { in: ITEM_TYPES }
  validates :item_id,   presence: true
  validates :quantity,  presence: true
  validates :quantity,  numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_address_id, presence: true

  validates :user, presence: true
  validates :item, presence: true
  validates :shipping_address, presence: true

end