require 'models/shared/displayable'
require 'models/shared/orderable'

class Coupon < ActiveRecord::Base
  belongs_to :batch
  belongs_to :used_by, class_name: 'User', foreign_key: :used_by

  validates :batch, presence: true
  delegate :promotion, to: :batch, allow_nil: true
  delegate :amount, to: :promotion, allow_nil: true
  delegate :available?, to: :promotion, allow_nil: true

  after_initialize :set_values

  def active?
    batch.try(:active?) && promotion.try(:active?)
  end

  def inactive?
    !active?
  end

  def deleted?
    batch.blank? || batch.deleted? || promotion.blank? || promotion.deleted?
  end

  def kept?
    !deleted?
  end

  def fulfill!(order, qty)
    if active?
      self.used = true
      self.used_by = order.user
      self.used_at = DateTime.now
      save!
      promotion.fulfill!(order, qty)
    end
  end

  def reverse!(order)
    promotion.reverse!(order)
  end

  protected

  def set_values
    if new_record?
      self.code = SecureRandom.hex(8).upcase
      self.used = false
      self.used_by = nil
      self.used_at = nil
    end
  end
end