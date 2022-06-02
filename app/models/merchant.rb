class Merchant < ApplicationRecord
  enum status: { 'Enabled' => 0, 'Disabled' => 1 }

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.top_five_merchants
    joins(invoices: %i[transactions invoice_items])
      .where(invoices: { status: 2 })
      .select('merchants.* , sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
      .group(:id)
      .order(total_revenue: :desc)
      .limit(5)
  end

  def best_day
    invoices.best_day
  end
end
