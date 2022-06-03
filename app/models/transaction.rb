class Transaction < ApplicationRecord
  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :result
  belongs_to :invoice

  enum result: %w[success failed]
  # enum status: { 'success' => 0, 'failed' => 1 }
end
