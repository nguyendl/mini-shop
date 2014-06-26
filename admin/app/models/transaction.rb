class Transaction < ServiceResource
  def self.instantiate(hash = {})
    super do |transaction|
      transaction.amount = BigDecimal.new(transaction.amount)
      transaction.committed_at = DateTime.parse(transaction.committed_at) if transaction.committed_at.present?
    end
  end
end
