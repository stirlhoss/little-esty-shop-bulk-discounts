class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy

  def fave_customers
    customers.joins(invoices: :transactions)
             .where(transactions: { result: 0 })
             .select("customers.*, count(transactions) as transaction_total")
             .group(:id)
             .order(transaction_total: :desc)
             .limit(5).to_a
  end

  def unshipped_items
    invoices.joins(:invoice_items)
            .select("items.*, invoice_items.status as invoicestatus, invoices.created_at as invoicecreation")
            .where(invoice_items: {status: 1})
            .order(:invoicecreation)
  end
end
