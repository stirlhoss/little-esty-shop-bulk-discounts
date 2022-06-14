class Invoice < ApplicationRecord
  enum status: { 'in progress' => 0, 'cancelled' => 1, 'completed' => 2 }

  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  validates_presence_of :status

  def total_revenue
    invoice_items.sum('quantity * unit_price').to_f
  end

  def self.best_day
    joins(:invoice_items)
      .where(status: 2)
      .select('invoices.created_at, max(invoice_items.unit_price * invoice_items.quantity) as best_day')
      .group(:created_at)
      .order(best_day: :desc)
      .first
  end

  def discounted_revenue(merchant_id)
    invoice_items.joins(item: :merchant)
                 .where(merchants: { id: merchant_id })
                 .sum(&:discounted_revenue).to_i
  end
end
