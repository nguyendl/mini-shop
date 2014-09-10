module BackendClient
  module Spec
    module Payloads
      # raw payloads
      def status_payload
        "{\"id\":1,\"resource_type\":\"Status\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"source_type\":\"Fulfillment\",\"source_id\":1,\"status\":1}"
      end

      def address_payload
        "{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"}"
      end

      def payment_method_payload
        "{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49584.84\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}}"
      end

      def transaction_payload
        "{\"id\":1,\"resource_type\":\"Transaction\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"committed\":true,\"committed_at\":\"2014-09-06T16:48:02-07:00\",\"committable\":false,\"user_id\":1,\"uuid\":\"74E331C6630FDEAEF8BDF1626AFB62EF\",\"payment_method_id\":1,\"billing_address_id\":1,\"amount\":\"177.18\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"},\"payment_method\":{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49584.84\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}},\"billing_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"}}"
      end

      def order_payload
        "{\"id\":1,\"resource_type\":\"Order\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":5,\"qty\":2,\"deleted\":false,\"deletable\":false,\"uuid\":\"C5C632CE\",\"purchase_id\":1,\"currency_id\":1,\"amount\":\"119.98\",\"tax\":\"13.2\",\"tax_rate\":\"0.11\",\"total\":\"133.18\",\"refund_id\":4,\"status_id\":26,\"unmarked\":false,\"marked\":true,\"failed\":false,\"invalid\":false,\"fulfilled\":false,\"reversed\":true,\"item\":{\"id\":5,\"resource_type\":\"PhysicalItem\",\"resource_id\":5,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Retail Edition\",\"description\":null,\"available\":true,\"qty\":39},\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"},\"refund\":{\"id\":4,\"resource_type\":\"Transaction\",\"resource_id\":4,\"created_at\":\"2014-09-06T16:48:03-07:00\",\"updated_at\":null,\"committed\":true,\"committed_at\":\"2014-09-06T16:48:03-07:00\",\"committable\":false,\"user_id\":1,\"uuid\":\"7C81A20B481ACB6799F04725500D35E8\",\"payment_method_id\":1,\"billing_address_id\":1,\"amount\":\"-133.18\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"},\"payment_method\":{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49584.84\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}},\"billing_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"}},\"statuses\":[{\"id\":2,\"resource_type\":\"Status\",\"resource_id\":2,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"source_type\":\"Order\",\"source_id\":1,\"status\":1},{\"id\":26,\"resource_type\":\"Status\",\"resource_id\":26,\"created_at\":\"2014-09-06T16:48:03-07:00\",\"updated_at\":null,\"source_type\":\"Order\",\"source_id\":1,\"status\":2}]}"
      end

      def purchase_payload
        "{\"id\":1,\"resource_type\":\"Purchase\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"changeable\":false,\"user_id\":1,\"payment_method_id\":1,\"billing_address_id\":1,\"shipping_address_id\":1,\"payment_id\":1,\"committed\":true,\"committed_at\":\"2014-09-06T16:48:02-07:00\",\"amount\":\"159.98\",\"tax\":\"17.2\",\"total\":\"177.18\",\"paid\":true,\"free\":false,\"payment_method\":{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49584.84\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}},\"billing_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"},\"shipping_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"},\"payment\":{\"id\":1,\"resource_type\":\"Transaction\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"committed\":true,\"committed_at\":\"2014-09-06T16:48:02-07:00\",\"committable\":false,\"user_id\":1,\"uuid\":\"74E331C6630FDEAEF8BDF1626AFB62EF\",\"payment_method_id\":1,\"billing_address_id\":1,\"amount\":\"177.18\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"},\"payment_method\":{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49584.84\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}},\"billing_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"}},\"orders\":[{\"id\":1,\"resource_type\":\"Order\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":5,\"qty\":2,\"deleted\":false,\"deletable\":false,\"uuid\":\"C5C632CE\",\"purchase_id\":1,\"currency_id\":1,\"amount\":\"119.98\",\"tax\":\"13.2\",\"tax_rate\":\"0.11\",\"total\":\"133.18\",\"refund_id\":4,\"status_id\":26,\"unmarked\":false,\"marked\":true,\"failed\":false,\"invalid\":false,\"fulfilled\":false,\"reversed\":true,\"item\":{\"id\":5,\"resource_type\":\"PhysicalItem\",\"resource_id\":5,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Retail Edition\",\"description\":null,\"available\":true,\"qty\":39},\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"},\"refund\":{\"id\":4,\"resource_type\":\"Transaction\",\"resource_id\":4,\"created_at\":\"2014-09-06T16:48:03-07:00\",\"updated_at\":null,\"committed\":true,\"committed_at\":\"2014-09-06T16:48:03-07:00\",\"committable\":false,\"user_id\":1,\"uuid\":\"7C81A20B481ACB6799F04725500D35E8\",\"payment_method_id\":1,\"billing_address_id\":1,\"amount\":\"-133.18\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"},\"payment_method\":{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49584.84\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}},\"billing_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"}},\"statuses\":[{\"id\":2,\"resource_type\":\"Status\",\"resource_id\":2,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"source_type\":\"Order\",\"source_id\":1,\"status\":1},{\"id\":26,\"resource_type\":\"Status\",\"resource_id\":26,\"created_at\":\"2014-09-06T16:48:03-07:00\",\"updated_at\":null,\"source_type\":\"Order\",\"source_id\":1,\"status\":2}]},{\"id\":2,\"resource_type\":\"Order\",\"resource_id\":2,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"item_type\":\"Coupon\",\"item_id\":1,\"qty\":1,\"deleted\":false,\"deletable\":false,\"uuid\":\"9F279E57\",\"purchase_id\":1,\"currency_id\":1,\"amount\":\"40.0\",\"tax\":\"4.0\",\"tax_rate\":\"0.1\",\"total\":\"44.0\",\"refund_id\":5,\"status_id\":31,\"unmarked\":false,\"marked\":true,\"failed\":false,\"invalid\":false,\"fulfilled\":false,\"reversed\":true,\"item\":{\"id\":1,\"resource_type\":\"Coupon\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"title\":\"Starcraft 2 Deluxe Edition 50% Off\",\"description\":null,\"promotion_id\":1,\"batch_id\":1,\"code\":\"5010F8B9086696D0\",\"used\":true,\"used_by\":1,\"used_at\":\"2014-09-06T16:48:02-07:00\",\"active\":true,\"available\":true},\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"},\"refund\":{\"id\":5,\"resource_type\":\"Transaction\",\"resource_id\":5,\"created_at\":\"2014-09-06T16:48:03-07:00\",\"updated_at\":null,\"committed\":true,\"committed_at\":\"2014-09-06T16:48:03-07:00\",\"committable\":false,\"user_id\":1,\"uuid\":\"37BC785701B9193E01D6FF03EFFEB366\",\"payment_method_id\":1,\"billing_address_id\":1,\"amount\":\"-44.0\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"},\"payment_method\":{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49584.84\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}},\"billing_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"}},\"statuses\":[{\"id\":7,\"resource_type\":\"Status\",\"resource_id\":7,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"source_type\":\"Order\",\"source_id\":2,\"status\":1},{\"id\":31,\"resource_type\":\"Status\",\"resource_id\":31,\"created_at\":\"2014-09-06T16:48:03-07:00\",\"updated_at\":null,\"source_type\":\"Order\",\"source_id\":2,\"status\":2}]}]}"
      end

      def user_payload
        "{\"id\":1,\"resource_type\":\"User\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":\"2014-09-06T16:48:01-07:00\",\"uuid\":\"F10A838FFF59AD82421F7643E7C532EE\",\"first_name\":\"John\",\"last_name\":\"Smith\",\"email\":\"user@email.com\",\"birthdate\":\"1980-01-01\",\"actv_code\":null,\"confirmed\":true,\"addresses\":[{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"}],\"payment_methods\":[{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49584.84\",\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}}]}"
      end

      def ownership_payload
        "{\"id\":5,\"resource_type\":\"Ownership\",\"resource_id\":5,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":\"4\",\"qty\":2,\"deleted\":false,\"deletable\":true,\"user_id\":1,\"order_id\":3,\"purchase_id\":2,\"item\":{\"id\":4,\"resource_type\":\"DigitalItem\",\"resource_id\":4,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Digital Edition\",\"description\":null,\"available\":true}}"
      end

      def shipment_payload
        "{\"id\":1,\"resource_type\":\"Shipment\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:02-07:00\",\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":5,\"qty\":2,\"user_id\":1,\"order_id\":1,\"purchase_id\":1,\"shipping_address_id\":1,\"item\":{\"id\":5,\"resource_type\":\"PhysicalItem\",\"resource_id\":5,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Retail Edition\",\"description\":null,\"available\":true,\"qty\":39},\"shipping_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"}}"
      end

      def currency_payload
        "{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}"
      end

      def pricepoint_price_payload
        "{\"id\":1,\"resource_type\":\"PricepointPrice\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"amount\":\"0.0\",\"pricepoint_id\":1,\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}}"
      end

      def pricepoint_payload
        "{\"id\":1,\"resource_type\":\"Pricepoint\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"Free Pricepoint\",\"pricepoint_prices\":[{\"id\":1,\"resource_type\":\"PricepointPrice\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"amount\":\"0.0\",\"pricepoint_id\":1,\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}},{\"id\":2,\"resource_type\":\"PricepointPrice\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"amount\":\"0.0\",\"pricepoint_id\":1,\"currency_id\":2,\"currency\":{\"id\":2,\"resource_type\":\"Currency\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"code\":\"EUR\",\"sign\":\"&#128;\"}},{\"id\":3,\"resource_type\":\"PricepointPrice\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"amount\":\"0.0\",\"pricepoint_id\":1,\"currency_id\":3,\"currency\":{\"id\":3,\"resource_type\":\"Currency\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"code\":\"KRW\",\"sign\":\"&#8361;\"}},{\"id\":4,\"resource_type\":\"PricepointPrice\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"amount\":\"0.0\",\"pricepoint_id\":1,\"currency_id\":4,\"currency\":{\"id\":4,\"resource_type\":\"Currency\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"code\":\"GBP\",\"sign\":\"&#163;\"}}]}"
      end

      def discount_payload
        "{\"id\":1,\"resource_type\":\"Discount\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"Black Friday Discount\",\"rate\":\"0.75\",\"start_at\":\"2013-11-25T00:00:00-08:00\",\"end_at\":\"2013-12-09T00:00:00-08:00\",\"discounted\":false,\"current_rate\":\"0.0\",\"current_active\":false}"
      end

      def price_payload
        "{\"id\":1,\"resource_type\":\"Price\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"SC2 Deluxe Promotion Price\",\"pricepoint_id\":3,\"discount_id\":4,\"pricepoint\":{\"id\":3,\"resource_type\":\"Pricepoint\",\"resource_id\":3,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"SC2 Deluxe Pricepoint\",\"pricepoint_prices\":[{\"id\":9,\"resource_type\":\"PricepointPrice\",\"resource_id\":9,\"created_at\":null,\"updated_at\":null,\"amount\":\"79.99\",\"pricepoint_id\":3,\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}},{\"id\":10,\"resource_type\":\"PricepointPrice\",\"resource_id\":10,\"created_at\":null,\"updated_at\":null,\"amount\":\"59.03\",\"pricepoint_id\":3,\"currency_id\":2,\"currency\":{\"id\":2,\"resource_type\":\"Currency\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"code\":\"EUR\",\"sign\":\"&#128;\"}},{\"id\":11,\"resource_type\":\"PricepointPrice\",\"resource_id\":11,\"created_at\":null,\"updated_at\":null,\"amount\":\"85213.35\",\"pricepoint_id\":3,\"currency_id\":3,\"currency\":{\"id\":3,\"resource_type\":\"Currency\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"code\":\"KRW\",\"sign\":\"&#8361;\"}},{\"id\":12,\"resource_type\":\"PricepointPrice\",\"resource_id\":12,\"created_at\":null,\"updated_at\":null,\"amount\":\"47.78\",\"pricepoint_id\":3,\"currency_id\":4,\"currency\":{\"id\":4,\"resource_type\":\"Currency\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"code\":\"GBP\",\"sign\":\"&#163;\"}}]},\"discount\":{\"id\":4,\"resource_type\":\"Discount\",\"resource_id\":4,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"Half Discount\",\"rate\":\"0.5\",\"start_at\":null,\"end_at\":null,\"discounted\":true,\"current_rate\":\"0.5\",\"current_active\":true}}"
      end

      def physical_item_payload
        "{\"id\":1,\"resource_type\":\"PhysicalItem\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Art Book\",\"description\":null,\"available\":true,\"qty\":34}"
      end

      def digital_item_payload
        "{\"id\":1,\"resource_type\":\"DigitalItem\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"Skin, Portraits, and Decals\",\"description\":null,\"available\":true}"
      end

      def bundled_payload
        "{\"id\":1,\"resource_type\":\"Bundled\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":4,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":4,\"resource_type\":\"DigitalItem\",\"resource_id\":4,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Digital Edition\",\"description\":null,\"available\":true}}"
      end

      def bundle_payload
        "{\"id\":1,\"resource_type\":\"Bundle\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Deluxe Edition\",\"description\":null,\"available\":true,\"changeable\":false,\"bundleds\":[{\"id\":1,\"resource_type\":\"Bundled\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":4,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":4,\"resource_type\":\"DigitalItem\",\"resource_id\":4,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Digital Edition\",\"description\":null,\"available\":true}},{\"id\":2,\"resource_type\":\"Bundled\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":1,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":1,\"resource_type\":\"DigitalItem\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"Skin, Portraits, and Decals\",\"description\":null,\"available\":true}},{\"id\":3,\"resource_type\":\"Bundled\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":2,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":2,\"resource_type\":\"DigitalItem\",\"resource_id\":2,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"World of Warcraft Banneling Pet\",\"description\":null,\"available\":true}},{\"id\":4,\"resource_type\":\"Bundled\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":3,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":3,\"resource_type\":\"DigitalItem\",\"resource_id\":3,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"Diablo 3 Blade Wings and Banner Sigil\",\"description\":null,\"available\":true}}]}"
      end

      def store_item_payload
        "{\"id\":1,\"resource_type\":\"StoreItem\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"deleted\":false,\"deletable\":true,\"title\":\"StarCraft 2 Retail Edition\",\"description\":null,\"item_type\":\"PhysicalItem\",\"item_id\":5,\"price_id\":2,\"name\":\"StarCraft 2 Retail Edition\",\"active\":true,\"available\":true,\"item\":{\"id\":5,\"resource_type\":\"PhysicalItem\",\"resource_id\":5,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Retail Edition\",\"description\":null,\"available\":true,\"qty\":39},\"price\":{\"id\":2,\"resource_type\":\"Price\",\"resource_id\":2,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"SC2 Standard Price\",\"pricepoint_id\":2,\"discount_id\":5,\"pricepoint\":{\"id\":2,\"resource_type\":\"Pricepoint\",\"resource_id\":2,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"SC2 Standard Pricepoint\",\"pricepoint_prices\":[{\"id\":5,\"resource_type\":\"PricepointPrice\",\"resource_id\":5,\"created_at\":null,\"updated_at\":null,\"amount\":\"59.99\",\"pricepoint_id\":2,\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}},{\"id\":6,\"resource_type\":\"PricepointPrice\",\"resource_id\":6,\"created_at\":null,\"updated_at\":null,\"amount\":\"44.27\",\"pricepoint_id\":2,\"currency_id\":2,\"currency\":{\"id\":2,\"resource_type\":\"Currency\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"code\":\"EUR\",\"sign\":\"&#128;\"}},{\"id\":7,\"resource_type\":\"PricepointPrice\",\"resource_id\":7,\"created_at\":null,\"updated_at\":null,\"amount\":\"63907.35\",\"pricepoint_id\":2,\"currency_id\":3,\"currency\":{\"id\":3,\"resource_type\":\"Currency\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"code\":\"KRW\",\"sign\":\"&#8361;\"}},{\"id\":8,\"resource_type\":\"PricepointPrice\",\"resource_id\":8,\"created_at\":null,\"updated_at\":null,\"amount\":\"35.83\",\"pricepoint_id\":2,\"currency_id\":4,\"currency\":{\"id\":4,\"resource_type\":\"Currency\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"code\":\"GBP\",\"sign\":\"&#163;\"}}]},\"discount\":{\"id\":5,\"resource_type\":\"Discount\",\"resource_id\":5,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"No Discount\",\"rate\":\"0.0\",\"start_at\":null,\"end_at\":null,\"discounted\":false,\"current_rate\":\"0.0\",\"current_active\":true}}}"
      end

      def promotion_payload
        "{\"id\":1,\"resource_type\":\"Promotion\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"deleted\":false,\"deletable\":false,\"title\":\"Starcraft 2 Deluxe Edition 50% Off\",\"description\":null,\"active\":true,\"activable\":false,\"item_type\":\"Bundle\",\"item_id\":1,\"price_id\":1,\"name\":\"Starcraft 2 Deluxe Edition Promotion\",\"available\":true,\"batch_count\":5,\"coupon_count\":150,\"used_coupon_count\":3,\"item\":{\"id\":1,\"resource_type\":\"Bundle\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Deluxe Edition\",\"description\":null,\"available\":true,\"changeable\":false,\"bundleds\":[{\"id\":1,\"resource_type\":\"Bundled\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":4,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":4,\"resource_type\":\"DigitalItem\",\"resource_id\":4,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"StarCraft 2 Digital Edition\",\"description\":null,\"available\":true}},{\"id\":2,\"resource_type\":\"Bundled\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":1,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":1,\"resource_type\":\"DigitalItem\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"Skin, Portraits, and Decals\",\"description\":null,\"available\":true}},{\"id\":3,\"resource_type\":\"Bundled\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":2,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":2,\"resource_type\":\"DigitalItem\",\"resource_id\":2,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"World of Warcraft Banneling Pet\",\"description\":null,\"available\":true}},{\"id\":4,\"resource_type\":\"Bundled\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":3,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":3,\"resource_type\":\"DigitalItem\",\"resource_id\":3,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"active\":true,\"activable\":false,\"deleted\":false,\"deletable\":false,\"title\":\"Diablo 3 Blade Wings and Banner Sigil\",\"description\":null,\"available\":true}}]},\"price\":{\"id\":1,\"resource_type\":\"Price\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"SC2 Deluxe Promotion Price\",\"pricepoint_id\":3,\"discount_id\":4,\"pricepoint\":{\"id\":3,\"resource_type\":\"Pricepoint\",\"resource_id\":3,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"SC2 Deluxe Pricepoint\",\"pricepoint_prices\":[{\"id\":9,\"resource_type\":\"PricepointPrice\",\"resource_id\":9,\"created_at\":null,\"updated_at\":null,\"amount\":\"79.99\",\"pricepoint_id\":3,\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}},{\"id\":10,\"resource_type\":\"PricepointPrice\",\"resource_id\":10,\"created_at\":null,\"updated_at\":null,\"amount\":\"59.03\",\"pricepoint_id\":3,\"currency_id\":2,\"currency\":{\"id\":2,\"resource_type\":\"Currency\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"code\":\"EUR\",\"sign\":\"&#128;\"}},{\"id\":11,\"resource_type\":\"PricepointPrice\",\"resource_id\":11,\"created_at\":null,\"updated_at\":null,\"amount\":\"85213.35\",\"pricepoint_id\":3,\"currency_id\":3,\"currency\":{\"id\":3,\"resource_type\":\"Currency\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"code\":\"KRW\",\"sign\":\"&#8361;\"}},{\"id\":12,\"resource_type\":\"PricepointPrice\",\"resource_id\":12,\"created_at\":null,\"updated_at\":null,\"amount\":\"47.78\",\"pricepoint_id\":3,\"currency_id\":4,\"currency\":{\"id\":4,\"resource_type\":\"Currency\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"code\":\"GBP\",\"sign\":\"&#163;\"}}]},\"discount\":{\"id\":4,\"resource_type\":\"Discount\",\"resource_id\":4,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"name\":\"Half Discount\",\"rate\":\"0.5\",\"start_at\":null,\"end_at\":null,\"discounted\":true,\"current_rate\":\"0.5\",\"current_active\":true}}}"
      end

      def batch_payload
        "{\"id\":1,\"resource_type\":\"Batch\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"deleted\":false,\"deletable\":false,\"active\":true,\"activable\":false,\"name\":\"Auto generated batch 1\",\"promotion_id\":1,\"coupon_count\":30,\"used_coupon_count\":3}"
      end

      def coupon_payload
        "{\"id\":1,\"resource_type\":\"Coupon\",\"resource_id\":1,\"created_at\":\"2014-09-06T16:48:01-07:00\",\"updated_at\":null,\"title\":\"Starcraft 2 Deluxe Edition 50% Off\",\"description\":null,\"promotion_id\":1,\"batch_id\":1,\"code\":\"5010F8B9086696D0\",\"used\":true,\"used_by\":1,\"used_at\":\"2014-09-06T16:48:02-07:00\",\"active\":true,\"available\":true}"
      end

      def email_payload
        "{\"to\":\"john.smith@email.com\",\"date\":\"2014-07-08T18:52:30-07:00\"}"
      end

      # parsed payloads
      [
        :user,
        :currency,
        :pricepoint_price,
        :pricepoint,
        :discount,
        :price,
        :physical_item,
        :digital_item,
        :bundle,
        :bundled,
        :store_item,
        :promotion,
        :batch,
        :coupon,
        :address,
        :payment_method,
        :transaction,
        :order,
        :purchase,
        :ownership,
        :shipment,
        :status,
        :email
      ].each do |model|
        define_method "parsed_#{model}_payload" do
          Yajl::Parser.parse send("#{model}_payload".to_sym)
        end
      end
    end

    module MockModels
      include Payloads

      [
        :user,
        :currency,
        :pricepoint_price,
        :pricepoint,
        :discount,
        :price,
        :physical_item,
        :digital_item,
        :bundle,
        :bundled,
        :store_item,
        :promotion,
        :batch,
        :coupon,
        :address,
        :payment_method,
        :transaction,
        :order,
        :purchase,
        :ownership,
        :shipment,
        :status
      ].each do |model|
        define_method "mocked_#{model}" do
          ::BackendClient.const_get(model.to_s.classify).new send("parsed_#{model}_payload".to_sym)
        end
      end
    end

    include Payloads
    include MockModels
  end
end