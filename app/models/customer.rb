class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name

  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def self.top_customers
    joins(invoices: :transactions)
      .where('transactions.result = ?', 'success')
      .group('customers.id')
      .select('customers.*')
      .order(count: :desc)
      .limit(5)
      # .count
  end
end
