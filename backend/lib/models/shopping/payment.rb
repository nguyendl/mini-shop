class Payment < ActiveRecord::Base

  belongs_to :payment_method
  belongs_to :billing_address

  attr_accessible :user_id, :payment_method_id, :billing_address_id, :amount, :currency_id

  validates :user_id,             presence: true
  validates :payment_method_id,   presence: true
  validates :billing_address_id,  presence: true
  validates :currency_id,         presence: true
  validates :amount,  presence: true
  validates :amount,  numericality: { greater_than: 0 }

  validates :user,              presence: true
  validates :payment_method,    presence: true
  validates :billing_address,   presence: true
  validates :currency,          presence: true

  before_create :set_values

  # stubbed
  def user
    true
  end

  # stubbed
  def currency
    true
  end

  protected

  def set_values
    self.uuid = SecureRandom.hex.upcase
    self.refunded = false
    true
  end
end