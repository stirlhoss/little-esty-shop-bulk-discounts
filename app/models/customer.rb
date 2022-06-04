class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name

  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def self.top_customers
    joins(:transactions)
      .where('transactions.result = ?', '0')
      .select('customers.* , count(transactions)')
      .group(:id)
      .order(count: :desc)
      .limit(5)
  end
end
