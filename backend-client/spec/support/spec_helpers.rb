module SpecHelpers
  module Common
    extend ActiveSupport::Concern

    included do
      let(:rand_str) { Faker::Lorem.words.join('') }
      let(:rand_num) { rand(1..50) }
      let(:qty) { rand(1..5) }
      let(:amount) { rand(1..20) }
    end

    def parse(json)
      Yajl::Parser.parse(json, symbolize_keys: true)
    end

    def collection(json)
      [parse(json)].to_json
    end
  end
end

module SpecHelpers
  module BackendClient
    extend ActiveSupport::Concern

    module Common
      extend ActiveSupport::Concern

      included do
        let(:namespace) { described_class.name.demodulize.underscore }
        let(:doubled_resource) { double(RestClient::Resource) }
        let(:resource_payload) { send("#{namespace}_payload".to_sym) }
        let(:params) { { key1: rand_str, key2: rand_num } }

        let(:model) { described_class.new id: rand_str }
        let(:instantiated_model) { described_class.instantiate(parse(resource_payload)) }
      end

      def backend_client_class(klass)
        BackendClient.const_get(klass)
      end

      def expect_resource
        expect(described_class).to receive(:resource).and_return(doubled_resource)
      end

      def expect_action(action, path, params, payload)
        expect_resource
        expect(doubled_resource).to receive(:[]).with(path).and_return(doubled_resource)
        match_expectation = receive(action)
        match_expectation = match_expectation.with(params) if params.present?
        match_expectation = match_expectation.and_return(payload) if payload.present?
        expect(doubled_resource).to match_expectation
      end

      [:get, :put, :post, :delete].each do |action|
        define_method "expect_#{action}" do |path, params = {}, payload = resource_payload|
          expect_action(action, path, params, payload)
        end
      end
    end

    module SamplePayloads
      extend ActiveSupport::Concern

      def user_payload
        "{\"id\":1,\"resource_type\":\"User\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":\"2014-06-18T16:08:23-07:00\",\"uuid\":\"F539887568E4CB8AF0E12D48687AAFB3\",\"first_name\":\"John\",\"last_name\":\"Smith\",\"email\":\"duyetln@yahoo.com\",\"birthdate\":\"1980-01-01\",\"actv_code\":null,\"confirmed\":true,\"addresses\":[{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"},{\"id\":2,\"resource_type\":\"Address\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"3501 Jamboree Rd\",\"line2\":null,\"line3\":null,\"city\":\"Newport Beach\",\"region\":\"CA\",\"postal_code\":\"92660\",\"country\":\"US\"}],\"payment_methods\":[{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49656.83\",\"currency_id\":1}]}"
      end

      def currency_payload
        "{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\",\"sign\":\"&#36;\"}"
      end

      def pricepoint_price_payload
        "{\"id\":1,\"resource_type\":\"PricepointPrice\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"amount\":\"0.0\",\"pricepoint_id\":1,\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\"}}"
      end

      def pricepoint_payload
        "{\"id\":1,\"resource_type\":\"Pricepoint\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"Free Pricepoint\",\"pricepoint_prices\":[{\"id\":1,\"resource_type\":\"PricepointPrice\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"amount\":\"0.0\",\"pricepoint_id\":1,\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\"}},{\"id\":2,\"resource_type\":\"PricepointPrice\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"amount\":\"0.0\",\"pricepoint_id\":1,\"currency_id\":2,\"currency\":{\"id\":2,\"resource_type\":\"Currency\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"code\":\"EUR\"}},{\"id\":3,\"resource_type\":\"PricepointPrice\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"amount\":\"0.0\",\"pricepoint_id\":1,\"currency_id\":3,\"currency\":{\"id\":3,\"resource_type\":\"Currency\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"code\":\"KRW\"}},{\"id\":4,\"resource_type\":\"PricepointPrice\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"amount\":\"0.0\",\"pricepoint_id\":1,\"currency_id\":4,\"currency\":{\"id\":4,\"resource_type\":\"Currency\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"code\":\"GBP\"}}]}"
      end

      def discount_payload
        "{\"id\":5,\"resource_type\":\"Discount\",\"resource_id\":5,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"Christmas Discount\",\"rate\":\"0.5\",\"start_at\":\"2013-12-23T00:00:00-08:00\",\"end_at\":\"2013-12-30T00:00:00-08:00\",\"discounted\":false}"
      end

      def price_payload
        "{\"id\":1,\"resource_type\":\"Price\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"SC2 Deluxe Promotion Price\",\"pricepoint_id\":3,\"discount_id\":1,\"pricepoint\":{\"id\":3,\"resource_type\":\"Pricepoint\",\"resource_id\":3,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"SC2 Deluxe Pricepoint\",\"pricepoint_prices\":[{\"id\":9,\"resource_type\":\"PricepointPrice\",\"resource_id\":9,\"created_at\":null,\"updated_at\":null,\"amount\":\"79.99\",\"pricepoint_id\":3,\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\"}},{\"id\":10,\"resource_type\":\"PricepointPrice\",\"resource_id\":10,\"created_at\":null,\"updated_at\":null,\"amount\":\"59.03\",\"pricepoint_id\":3,\"currency_id\":2,\"currency\":{\"id\":2,\"resource_type\":\"Currency\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"code\":\"EUR\"}},{\"id\":11,\"resource_type\":\"PricepointPrice\",\"resource_id\":11,\"created_at\":null,\"updated_at\":null,\"amount\":\"85213.35\",\"pricepoint_id\":3,\"currency_id\":3,\"currency\":{\"id\":3,\"resource_type\":\"Currency\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"code\":\"KRW\"}},{\"id\":12,\"resource_type\":\"PricepointPrice\",\"resource_id\":12,\"created_at\":null,\"updated_at\":null,\"amount\":\"47.78\",\"pricepoint_id\":3,\"currency_id\":4,\"currency\":{\"id\":4,\"resource_type\":\"Currency\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"code\":\"GBP\"}}]},\"discount\":{\"id\":1,\"resource_type\":\"Discount\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"Half Discount\",\"rate\":\"0.5\",\"start_at\":null,\"end_at\":null,\"discounted\":true}}"
      end

      def physical_item_payload
        "{\"id\":1,\"resource_type\":\"PhysicalItem\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Art Book\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":34}"
      end

      def digital_item_payload
        "{\"id\":1,\"resource_type\":\"DigitalItem\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Skin, Portraits, and Decals\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}"
      end

      def bundle_payload
        "{\"id\":1,\"resource_type\":\"Bundle\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Deluxe Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"bundleds\":[{\"id\":1,\"resource_type\":\"Bundled\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":4,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":4,\"resource_type\":\"DigitalItem\",\"resource_id\":4,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Digital Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}},{\"id\":2,\"resource_type\":\"Bundled\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":1,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":1,\"resource_type\":\"DigitalItem\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Skin, Portraits, and Decals\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}},{\"id\":3,\"resource_type\":\"Bundled\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":2,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":2,\"resource_type\":\"DigitalItem\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"World of Warcraft Banneling Pet\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}},{\"id\":4,\"resource_type\":\"Bundled\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":3,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":3,\"resource_type\":\"DigitalItem\",\"resource_id\":3,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Diablo 3 Blade Wings and Banner Sigil\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}}]}"
      end

      def bundled_payload
        "{\"id\":1,\"resource_type\":\"Bundled\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":4,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":4,\"resource_type\":\"DigitalItem\",\"resource_id\":4,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Digital Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}}"
      end

      def store_item_payload
        "{\"id\":1,\"resource_type\":\"StoreItem\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"deleted\":false,\"deletable\":true,\"title\":\"StarCraft 2 Retail Edition\",\"description\":null,\"item_type\":\"PhysicalItem\",\"item_id\":5,\"price_id\":2,\"name\":\"StarCraft 2 Retail Edition\",\"active\":true,\"available\":true,\"item\":{\"id\":5,\"resource_type\":\"PhysicalItem\",\"resource_id\":5,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Retail Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":22},\"price\":{\"id\":2,\"resource_type\":\"Price\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"SC2 Standard Price\",\"pricepoint_id\":2,\"discount_id\":2,\"pricepoint\":{\"id\":2,\"resource_type\":\"Pricepoint\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"SC2 Standard Pricepoint\",\"pricepoint_prices\":[{\"id\":5,\"resource_type\":\"PricepointPrice\",\"resource_id\":5,\"created_at\":null,\"updated_at\":null,\"amount\":\"59.99\",\"pricepoint_id\":2,\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\"}},{\"id\":6,\"resource_type\":\"PricepointPrice\",\"resource_id\":6,\"created_at\":null,\"updated_at\":null,\"amount\":\"44.27\",\"pricepoint_id\":2,\"currency_id\":2,\"currency\":{\"id\":2,\"resource_type\":\"Currency\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"code\":\"EUR\"}},{\"id\":7,\"resource_type\":\"PricepointPrice\",\"resource_id\":7,\"created_at\":null,\"updated_at\":null,\"amount\":\"63907.35\",\"pricepoint_id\":2,\"currency_id\":3,\"currency\":{\"id\":3,\"resource_type\":\"Currency\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"code\":\"KRW\"}},{\"id\":8,\"resource_type\":\"PricepointPrice\",\"resource_id\":8,\"created_at\":null,\"updated_at\":null,\"amount\":\"35.83\",\"pricepoint_id\":2,\"currency_id\":4,\"currency\":{\"id\":4,\"resource_type\":\"Currency\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"code\":\"GBP\"}}]},\"discount\":{\"id\":2,\"resource_type\":\"Discount\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"No Discount\",\"rate\":\"0.0\",\"start_at\":null,\"end_at\":null,\"discounted\":false}}}"
      end

      def promotion_payload
        "{\"id\":1,\"resource_type\":\"Promotion\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"deleted\":false,\"deletable\":false,\"title\":\"Starcraft 2 Deluxe Edition 50% Off\",\"description\":null,\"active\":true,\"activable\":false,\"item_type\":\"Bundle\",\"item_id\":1,\"price_id\":1,\"name\":\"Starcraft 2 Deluxe Edition Promotion\",\"item\":{\"id\":1,\"resource_type\":\"Bundle\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Deluxe Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"bundleds\":[{\"id\":1,\"resource_type\":\"Bundled\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":4,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":4,\"resource_type\":\"DigitalItem\",\"resource_id\":4,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Digital Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}},{\"id\":2,\"resource_type\":\"Bundled\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":1,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":1,\"resource_type\":\"DigitalItem\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Skin, Portraits, and Decals\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}},{\"id\":3,\"resource_type\":\"Bundled\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":2,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":2,\"resource_type\":\"DigitalItem\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"World of Warcraft Banneling Pet\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}},{\"id\":4,\"resource_type\":\"Bundled\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":3,\"qty\":1,\"bundle_id\":1,\"item\":{\"id\":3,\"resource_type\":\"DigitalItem\",\"resource_id\":3,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Diablo 3 Blade Wings and Banner Sigil\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}}]},\"price\":{\"id\":1,\"resource_type\":\"Price\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"SC2 Deluxe Promotion Price\",\"pricepoint_id\":3,\"discount_id\":1,\"pricepoint\":{\"id\":3,\"resource_type\":\"Pricepoint\",\"resource_id\":3,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"SC2 Deluxe Pricepoint\",\"pricepoint_prices\":[{\"id\":9,\"resource_type\":\"PricepointPrice\",\"resource_id\":9,\"created_at\":null,\"updated_at\":null,\"amount\":\"79.99\",\"pricepoint_id\":3,\"currency_id\":1,\"currency\":{\"id\":1,\"resource_type\":\"Currency\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"code\":\"USD\"}},{\"id\":10,\"resource_type\":\"PricepointPrice\",\"resource_id\":10,\"created_at\":null,\"updated_at\":null,\"amount\":\"59.03\",\"pricepoint_id\":3,\"currency_id\":2,\"currency\":{\"id\":2,\"resource_type\":\"Currency\",\"resource_id\":2,\"created_at\":null,\"updated_at\":null,\"code\":\"EUR\"}},{\"id\":11,\"resource_type\":\"PricepointPrice\",\"resource_id\":11,\"created_at\":null,\"updated_at\":null,\"amount\":\"85213.35\",\"pricepoint_id\":3,\"currency_id\":3,\"currency\":{\"id\":3,\"resource_type\":\"Currency\",\"resource_id\":3,\"created_at\":null,\"updated_at\":null,\"code\":\"KRW\"}},{\"id\":12,\"resource_type\":\"PricepointPrice\",\"resource_id\":12,\"created_at\":null,\"updated_at\":null,\"amount\":\"47.78\",\"pricepoint_id\":3,\"currency_id\":4,\"currency\":{\"id\":4,\"resource_type\":\"Currency\",\"resource_id\":4,\"created_at\":null,\"updated_at\":null,\"code\":\"GBP\"}}]},\"discount\":{\"id\":1,\"resource_type\":\"Discount\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"name\":\"Half Discount\",\"rate\":\"0.5\",\"start_at\":null,\"end_at\":null,\"discounted\":true}}}"
      end

      def batch_payload
        "{\"id\":1,\"resource_type\":\"Batch\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"deleted\":false,\"deletable\":false,\"active\":true,\"activable\":false,\"name\":\"Auto generated batch 1\"}"
      end

      def coupon_payload
        "{\"id\":1,\"resource_type\":\"Coupon\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Starcraft 2 Deluxe Edition 50% Off\",\"description\":null,\"promotion_id\":1,\"batch_id\":1,\"code\":\"DA35104880F91B33\",\"used\":true,\"used_by\":1,\"used_at\":\"2014-06-18T15:36:04-07:00\"}"
      end

      def address_payload
        "{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"}"
      end

      def payment_method_payload
        "{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49656.83\",\"currency_id\":1}"
      end

      def transaction_payload
        "{\"id\":1,\"resource_type\":\"Transaction\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:36:01-07:00\",\"updated_at\":null,\"committed\":true,\"committed_at\":\"2014-06-18T15:36:04-07:00\",\"committable\":false,\"user_id\":1,\"uuid\":\"D3E86FB0BEF9B506F84B263E26E7D64C\",\"payment_method_id\":1,\"billing_address_id\":1,\"amount\":\"343.17\",\"currency_id\":1}"
      end

      def order_payload
        "{\"id\":5,\"resource_type\":\"Order\",\"resource_id\":5,\"created_at\":\"2014-06-28T21:47:02-07:00\",\"updated_at\":null,\"item_type\":\"Bundle\",\"item_id\":2,\"qty\":2,\"deleted\":false,\"deletable\":false,\"uuid\":\"22C4A3A3\",\"purchase_id\":2,\"currency_id\":1,\"amount\":\"59.99\",\"tax\":\"10.8\",\"tax_rate\":\"0.18\",\"total\":\"70.79\",\"refund_id\":3,\"status_id\":34,\"unmarked\":false,\"marked\":true,\"failed\":false,\"invalid\":false,\"fulfilled\":false,\"reversed\":true,\"item\":{\"id\":2,\"resource_type\":\"Bundle\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Collector's Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"bundleds\":[{\"id\":5,\"resource_type\":\"Bundled\",\"resource_id\":5,\"created_at\":null,\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":5,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":5,\"resource_type\":\"PhysicalItem\",\"resource_id\":5,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Retail Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":22}},{\"id\":6,\"resource_type\":\"Bundled\",\"resource_id\":6,\"created_at\":null,\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":1,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":1,\"resource_type\":\"PhysicalItem\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Art Book\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":34}},{\"id\":7,\"resource_type\":\"Bundled\",\"resource_id\":7,\"created_at\":null,\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":2,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":2,\"resource_type\":\"PhysicalItem\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Zerg Rush Mousepad\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":28}},{\"id\":8,\"resource_type\":\"Bundled\",\"resource_id\":8,\"created_at\":null,\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":3,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":3,\"resource_type\":\"PhysicalItem\",\"resource_id\":3,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Behind the Scenes DVD Set\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":37}},{\"id\":9,\"resource_type\":\"Bundled\",\"resource_id\":9,\"created_at\":null,\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":4,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":4,\"resource_type\":\"PhysicalItem\",\"resource_id\":4,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Soundtrack\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":30}},{\"id\":10,\"resource_type\":\"Bundled\",\"resource_id\":10,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":1,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":1,\"resource_type\":\"DigitalItem\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Skin, Portraits, and Decals\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}},{\"id\":11,\"resource_type\":\"Bundled\",\"resource_id\":11,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":2,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":2,\"resource_type\":\"DigitalItem\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"World of Warcraft Banneling Pet\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}},{\"id\":12,\"resource_type\":\"Bundled\",\"resource_id\":12,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":3,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":3,\"resource_type\":\"DigitalItem\",\"resource_id\":3,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Diablo 3 Blade Wings and Banner Sigil\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}}]},\"refund\":{\"id\":3,\"resource_type\":\"Transaction\",\"resource_id\":3,\"created_at\":\"2014-06-28T21:49:03-07:00\",\"updated_at\":null,\"committed\":true,\"committable\":false,\"user_id\":1,\"uuid\":\"BD92A48559F170230EBA5D7581BB4660\",\"payment_method_id\":1,\"billing_address_id\":1,\"amount\":\"-70.79\",\"currency_id\":1},\"statuses\":[{\"id\":25,\"resource_type\":\"Status\",\"resource_id\":25,\"created_at\":\"2014-06-28T21:47:09-07:00\",\"updated_at\":null,\"source_type\":\"Order\",\"source_id\":5,\"status\":1},{\"id\":34,\"resource_type\":\"Status\",\"resource_id\":34,\"created_at\":\"2014-06-28T21:49:03-07:00\",\"updated_at\":null,\"source_type\":\"Order\",\"source_id\":5,\"status\":2}]}"
      end

      def purchase_payload
        "{\"id\":2,\"resource_type\":\"Purchase\",\"resource_id\":2,\"created_at\":\"2014-06-28T21:43:01-07:00\",\"updated_at\":null,\"user_id\":1,\"payment_method_id\":1,\"billing_address_id\":1,\"shipping_address_id\":1,\"payment_id\":2,\"committed\":true,\"committed_at\":\"2014-06-28T21:47:09-07:00\",\"payment_method\":{\"id\":1,\"resource_type\":\"PaymentMethod\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"user_id\":1,\"name\":\"My online pocket\",\"balance\":\"49656.83\",\"currency_id\":1},\"billing_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"},\"shipping_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"},\"payment\":{\"id\":2,\"resource_type\":\"Transaction\",\"resource_id\":2,\"created_at\":\"2014-06-28T21:47:09-07:00\",\"updated_at\":null,\"committed\":true,\"committable\":false,\"user_id\":1,\"uuid\":\"26AFD0D18EAB75022A8287BDB97ADFB6\",\"payment_method_id\":1,\"billing_address_id\":1,\"amount\":\"70.79\",\"currency_id\":1},\"orders\":[{\"id\":5,\"resource_type\":\"Order\",\"resource_id\":5,\"created_at\":\"2014-06-28T21:47:02-07:00\",\"updated_at\":null,\"item_type\":\"Bundle\",\"item_id\":2,\"qty\":2,\"deleted\":false,\"deletable\":false,\"uuid\":\"22C4A3A3\",\"purchase_id\":2,\"currency_id\":1,\"amount\":\"59.99\",\"tax\":\"10.8\",\"tax_rate\":\"0.18\",\"total\":\"70.79\",\"refund_id\":3,\"status_id\":34,\"unmarked\":false,\"marked\":true,\"failed\":false,\"invalid\":false,\"fulfilled\":false,\"reversed\":true,\"item\":{\"id\":2,\"resource_type\":\"Bundle\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Collector's Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"bundleds\":[{\"id\":5,\"resource_type\":\"Bundled\",\"resource_id\":5,\"created_at\":null,\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":5,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":5,\"resource_type\":\"PhysicalItem\",\"resource_id\":5,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Retail Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":22}},{\"id\":6,\"resource_type\":\"Bundled\",\"resource_id\":6,\"created_at\":null,\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":1,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":1,\"resource_type\":\"PhysicalItem\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Art Book\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":34}},{\"id\":7,\"resource_type\":\"Bundled\",\"resource_id\":7,\"created_at\":null,\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":2,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":2,\"resource_type\":\"PhysicalItem\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Zerg Rush Mousepad\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":28}},{\"id\":8,\"resource_type\":\"Bundled\",\"resource_id\":8,\"created_at\":null,\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":3,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":3,\"resource_type\":\"PhysicalItem\",\"resource_id\":3,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Behind the Scenes DVD Set\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":37}},{\"id\":9,\"resource_type\":\"Bundled\",\"resource_id\":9,\"created_at\":null,\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":4,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":4,\"resource_type\":\"PhysicalItem\",\"resource_id\":4,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Soundtrack\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":30}},{\"id\":10,\"resource_type\":\"Bundled\",\"resource_id\":10,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":1,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":1,\"resource_type\":\"DigitalItem\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Skin, Portraits, and Decals\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}},{\"id\":11,\"resource_type\":\"Bundled\",\"resource_id\":11,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":2,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":2,\"resource_type\":\"DigitalItem\",\"resource_id\":2,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"World of Warcraft Banneling Pet\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}},{\"id\":12,\"resource_type\":\"Bundled\",\"resource_id\":12,\"created_at\":null,\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":3,\"qty\":1,\"bundle_id\":2,\"item\":{\"id\":3,\"resource_type\":\"DigitalItem\",\"resource_id\":3,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Diablo 3 Blade Wings and Banner Sigil\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}}]},\"refund\":{\"id\":3,\"resource_type\":\"Transaction\",\"resource_id\":3,\"created_at\":\"2014-06-28T21:49:03-07:00\",\"updated_at\":null,\"committed\":true,\"committable\":false,\"user_id\":1,\"uuid\":\"BD92A48559F170230EBA5D7581BB4660\",\"payment_method_id\":1,\"billing_address_id\":1,\"amount\":\"-70.79\",\"currency_id\":1},\"statuses\":[{\"id\":25,\"resource_type\":\"Status\",\"resource_id\":25,\"created_at\":\"2014-06-28T21:47:09-07:00\",\"updated_at\":null,\"source_type\":\"Order\",\"source_id\":5,\"status\":1},{\"id\":34,\"resource_type\":\"Status\",\"resource_id\":34,\"created_at\":\"2014-06-28T21:49:03-07:00\",\"updated_at\":null,\"source_type\":\"Order\",\"source_id\":5,\"status\":2}]}]}"
      end

      def ownership_payload
        "{\"id\":1,\"resource_type\":\"Ownership\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:36:04-07:00\",\"updated_at\":null,\"item_type\":\"DigitalItem\",\"item_id\":\"1\",\"qty\":2,\"deleted\":false,\"deletable\":true,\"user_id\":1,\"order_id\":1,\"item\":{\"id\":1,\"resource_type\":\"DigitalItem\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"Skin, Portraits, and Decals\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true}}"
      end

      def shipment_payload
        "{\"id\":1,\"resource_type\":\"Shipment\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:36:04-07:00\",\"updated_at\":null,\"item_type\":\"PhysicalItem\",\"item_id\":5,\"qty\":2,\"user_id\":1,\"order_id\":1,\"shipping_address_id\":1,\"item\":{\"id\":5,\"resource_type\":\"PhysicalItem\",\"resource_id\":5,\"created_at\":\"2014-06-18T15:34:21-07:00\",\"updated_at\":null,\"title\":\"StarCraft 2 Retail Edition\",\"description\":null,\"active\":true,\"deleted\":false,\"available\":true,\"qty\":22},\"shipping_address\":{\"id\":1,\"resource_type\":\"Address\",\"resource_id\":1,\"created_at\":null,\"updated_at\":null,\"user_id\":1,\"line1\":\"2800 E Observatory Ave\",\"line2\":null,\"line3\":null,\"city\":\"Los Angeles\",\"region\":\"CA\",\"postal_code\":\"90027\",\"country\":\"US\"}}"
      end

      def status_payload
        "{\"id\":1,\"resource_type\":\"Status\",\"resource_id\":1,\"created_at\":\"2014-06-18T15:36:04-07:00\",\"updated_at\":null,\"source_type\":\"Fulfillment\",\"source_id\":1,\"status\":1}"
      end

      def email_payload
        "{\"to\":\"john.smith@email.com\",\"date\":\"2014-07-08T18:52:30-07:00\"}"
      end
    end

    include Common
    include SamplePayloads
  end
end
