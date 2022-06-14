class InvoiceItem < ApplicationRecord
  enum status: { 'pending' => 0, 'packaged' => 1, 'shipped' => 2 }

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant
  validates_presence_of :status

  def self.incomplete_inv
    where(status: %w[pending packaged])
      .order(:created_at)
  end

  def best_discount
    bulk_discounts.where("#{quantity} >= threshold")
                  .select('bulk_discounts.*')
                  .group('bulk_discounts.id, merchants.id, items.id')
                  .order(percentage: :desc)
                  .first
  end

  def discounted_revenue
    if best_discount
      (1 - best_discount.percentage.to_f / 100) * (quantity * unit_price)
    else
      total_revenue
    end
  end

  def total_revenue
    quantity * unit_price
  end
end
