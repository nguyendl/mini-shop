class Coupon < ServiceResource
  def self.instantiate(hash = {})
    super do |coupon|
      coupon.used_at = DateTime.parse(coupon.used_at) if coupon.used_at.present?
    end
  end

  def self.find_by_code(code)
    parse(resource["/#{code}"].get) do |hash|
      instantiate(hash)
    end
  end
end