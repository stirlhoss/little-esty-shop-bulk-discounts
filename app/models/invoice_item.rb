class InvoiceItem < ApplicationRecord
  enum status: { 'pending' => 0, 'packaged' => 1, 'shipped' => 2 }

  belongs_to :invoice
  belongs_to :item

  validates_presence_of :status

  def total_revenue
    invoice_items.sum("quantity * unit_price").to_f / 100
  end
end
