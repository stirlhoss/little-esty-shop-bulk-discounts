require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  before :each do
    # InvoiceItem.destroy_all
    # Transaction.destroy_all
    # Invoice.destroy_all
    # Customer.destroy_all
    # Merchant.destroy_all
    @merchant = Merchant.create!(name: 'Saba')
    @item_1 = @merchant.items.create!(name: 'Pencil', unit_price: 4, description: 'Writes things.')
    @item_2 = @merchant.items.create!(name: 'Pen', unit_price: 5, description: 'Writes things, but dark.')
    @item_3 = @merchant.items.create!(name: 'Marker', unit_price: 6, description: 'Writes things, but dark, and thicc.')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @invoice_1 = @customer_1.invoices.create(status: "completed")
    @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 4, status: 0)
    @invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249631', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249633', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')

    @customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
    @invoice_4 = @customer_2.invoices.create(status: "completed")
    @item_1.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 3, unit_price: 4, status: 1)
    @invoice_4.transactions.create!(credit_card_number: '5654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '5654405418249631', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '5654405418249633', result: 'success')

    @customer_3 = Customer.create!(first_name: 'Toy', last_name: 'Mariah')
    @invoice_7 = @customer_3.invoices.create(status: "completed")
    @item_2.invoice_items.create!(invoice_id: @invoice_7.id, quantity: 4, unit_price: 5, status: 0)
    @invoice_7.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_7.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_7.transactions.create!(credit_card_number: '6654405418249631', result: 'success')

    @customer_4 = Customer.create!(first_name: 'Joy', last_name: 'Braun')
    @invoice_9 = @customer_4.invoices.create(status: "completed")
    @item_2.invoice_items.create!(invoice_id: @invoice_9.id, quantity: 4, unit_price: 5, status: 1)
    @invoice_9.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_9.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_9.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_9.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_9.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_9.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_5 = Customer.create!(first_name: 'Eileen', last_name: 'Gerlach')
    @invoice_11 = @customer_5.invoices.create(status: "completed")
    @item_2.invoice_items.create!(invoice_id: @invoice_11.id, quantity: 4, unit_price: 5, status: 0)
    @invoice_11.transactions.create!(credit_card_number: '6654405418249643', result: 'success')

    @customer_6 = Customer.create!(first_name: 'Smark', last_name: 'Mrains')
    @invoice_13 = @customer_6.invoices.create(status: "in progress")
    @item_2.invoice_items.create!(invoice_id: @invoice_11.id, quantity: 4, unit_price: 5, status: 'pending')
    @invoice_13.transactions.create!(credit_card_number: '6654405418249644', result: 'failed')
  end

  it "#fave_customers" do
    expect(@merchant.fave_customers).to eq([@customer_4, @customer_1, @customer_2, @customer_3, @customer_5])
  end

  
end
