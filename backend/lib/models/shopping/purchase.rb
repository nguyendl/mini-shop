require 'models/shared/committable'

class Purchase < ActiveRecord::Base
  STATUS = { fulfilled: 1, reversed: 2 }

  include Committable
  include Status::Mixin

  attr_readonly :user_id

  has_many :orders

  belongs_to :payment_method
  belongs_to :billing_address,  class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :payment, class_name: 'Transaction'
  belongs_to :user

  validates :user,             presence: true
  validates :payment_method,   presence: true, if: :committed?
  validates :billing_address,  presence: true, if: :committed?
  validates :shipping_address, presence: true, if: :committed?

  validates :committed, uniqueness: { scope: :user_id }, unless: :committed?

  delegate :currency, to: :payment_method, prefix: true, allow_nil: true

  def self.pending_purchase(user)
    where(user_id: user.id).pending.first_or_create
  end

  def add_or_update(item, currency, qty = 1)
    if pending?
      order = orders.add_or_update(item, qty: qty, acc: false) do |ordr|
        ordr.currency = currency
      end
      reload && order
    end
  end

  def remove(item)
    if pending?
      order = orders.retrieve(item) do |ordr|
        ordr.delete!
      end
      reload && order
    end
  end

  [:amount, :tax, :total].each do |method|
    define_method method do |currency = payment_method_currency|
      orders.reduce(BigDecimal('0.0')) do |a, e|
        a += e.send(method, currency)
      end
    end
  end

  def fulfill!
    if committed? && unmarked?
      if payment_method.enough?(total)
        make_payment!
        orders.each do |order|
          order.fulfill!
        end
        transactions.each do |transaction|
          transaction.commit!
        end
        mark_fulfilled!
        fulfilled?
      end
    end
  end

  def reverse!
    if committed? && fulfilled?
      orders.each do |order|
        order.reverse!
      end
      mark_reversed!
      reversed?
    end
  end

  def transactions
    [] + orders.map(&:refund) << payment
  end

  def commit!
    normalize!
    super
  end

  def normalize!
    if payment_method.present?
      orders.each do |order|
        order.currency = payment_method_currency
        order.save!
      end
    end
  end

  private

  def make_payment!
    if committed?
      unless payment.present?
        build_payment
        payment.user = user
        payment.amount = total
        payment.currency = payment_method_currency
        payment.payment_method = payment_method
        payment.billing_address = billing_address
        payment.save!
        save!
      end
      payment
    end
  end
end
