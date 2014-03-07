require "models/shared/item_resource"

class BundleItem < ActiveRecord::Base

  include ItemResource

  has_many :bundlings, foreign_key: :bundle_id

  def add_or_update(item, qty=1, acc=true)
    bundlings.add_or_update(item, qty, acc) if persisted? && !deleted?
  end

  def remove(item)
    if persisted? && !deleted?
      bundling = bundlings.get(item)
      bundling.present? && bundlings.destroy(bundling) 
    end
  end

  def items
    bundlings.map(&:item)
  end

  def available?
    super && items.present? && items.all?(&:available?)
  end

  def prepare!(order)
    items.all?{ |item| item.prepare!(order) }
  end

end