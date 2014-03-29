class ShippingFulfillment < Fulfillment
  protected

  def process_fulfillment!
    shipment = Shipment.where(
      order_id: order.id,
      item_type: item.class,
      item_id: item.id
    ).first_or_initialize

    shipment.user = order.user
    shipment.qty ||= 0
    shipment.qty  += 1
    shipment.shipping_address = order.shipping_address
    shipment.save!
  end
end
