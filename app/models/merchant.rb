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
             # require "pry"; binding.pry
  end

  def unshipped_items
    invoices.joins(:items)
            .select("items.*, invoice_items, invoices.created_at")
            .where(invoice_items: {status: 1})
            .distinct
            .order("invoices.created_at")
  end
end
