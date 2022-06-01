require 'rails_helper'

RSpec.describe 'Admin Merchant Index', type: :feature do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')
    @m2 = Merchant.create!(name: 'Merchant 2', status: 0)
    @m3 = Merchant.create!(name: 'Merchant 3')
    @m4 = Merchant.create!(name: 'Merchant 4', status: 0)
    @m5 = Merchant.create!(name: 'Merchant 5', status: 0)
    @m6 = Merchant.create!(name: 'Merchant 6')

    @c1 = Customer.create!(first_name: 'Yo', last_name: 'Yoz')
    @c2 = Customer.create!(first_name: 'Hey', last_name: 'Heyz')

    @i1 = Invoice.create!(customer_id: @c1.id, status: 2)
    @i2 = Invoice.create!(customer_id: @c1.id, status: 2)
    @i3 = Invoice.create!(customer_id: @c2.id, status: 2)
    @i4 = Invoice.create!(customer_id: @c2.id, status: 2)
    @i5 = Invoice.create!(customer_id: @c2.id, status: 2)
    @i6 = Invoice.create!(customer_id: @c2.id, status: 2)
    @i7 = Invoice.create!(customer_id: @c1.id, status: 2)
    @i8 = Invoice.create!(customer_id: @c1.id, status: 2)
    @i9 = Invoice.create!(customer_id: @c1.id, status: 2)
    @i10 = Invoice.create!(customer_id: @c2.id, status: 2)
    @i11 = Invoice.create!(customer_id: @c2.id, status: 2)
    @i12 = Invoice.create!(customer_id: @c2.id, status: 2)

    @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
    @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8,
                           merchant_id: @m2.id)
    @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m3.id)
    @item_4 = Item.create!(name: 'test', description: 'lalala', unit_price: 6, merchant_id: @m4.id)
    @item_5 = Item.create!(name: 'rest', description: 'dont test me', unit_price: 12, merchant_id: @m5.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_2.id, quantity: 6, unit_price: 8, status: 1)
    @ii_3 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 16, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @i4.id, item_id: @item_3.id, quantity: 2, unit_price: 5, status: 2)
    @ii_5 = InvoiceItem.create!(invoice_id: @i5.id, item_id: @item_3.id, quantity: 10, unit_price: 5, status: 2)
    @ii_6 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_3.id, quantity: 7, unit_price: 5, status: 2)
    @ii_7 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)

    @t1 = Transaction.create!(credit_card_number: 203_942, result: 1, invoice_id: @i1.id)
    @t2 = Transaction.create!(credit_card_number: 230_948, result: 1, invoice_id: @i2.id)
    @t3 = Transaction.create!(credit_card_number: 234_092, result: 1, invoice_id: @i3.id)
    @t4 = Transaction.create!(credit_card_number: 230_429, result: 1, invoice_id: @i5.id)
    @t5 = Transaction.create!(credit_card_number: 102_938, result: 1, invoice_id: @i6.id)
    @t6 = Transaction.create!(credit_card_number: 102_938, result: 1, invoice_id: @i1.id)

    visit admin_merchants_path
  end

  it 'should display all merchants by name' do
    expect(page).to have_content(@m1.name)
    expect(page).to have_content(@m2.name)
    expect(page).to have_content(@m3.name)
    expect(page).to have_content(@m4.name)
    expect(page).to have_content(@m5.name)
    expect(page).to have_content(@m6.name)
  end

  it 'should allow disabling and enabling a merchant' do
    within "#disabled-#{@m1.id}" do
      click_on 'Enable'
    end

    expect(current_path).to eq(admin_merchants_path)

    within "#enabled-#{@m1.id}" do
      expect(page).to have_content(@m1.name)
      expect(page).to have_button('Disable')
    end
  end

  it 'should have two sections for Enabled/Disabled Merchants' do
    within '#disabled' do
      within "#disabled-#{@m1.id}" do
        click_on 'Enable'
      end
    end

    within '#enabled' do
      within "#enabled-#{@m1.id}" do
        expect(page).to have_content(@m1.name)
        expect(page).to have_button('Disable')
      end
    end
  end
end
