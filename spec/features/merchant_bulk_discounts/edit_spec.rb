require 'rails_helper'

RSpec.describe MerchantBulkDiscounts: :Edit do
  before :each do
    @merchant1 = Merchant.create!(name: 'Bobby Brown')
    @merchant2 = Merchant.create!(name: 'Steven Right')
    @discount1 = BulkDiscount.create!(percentage: 10, threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percentage: 20, threshold: 20, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percentage: 30, threshold: 30, merchant_id: @merchant1.id)
    @discount4 = BulkDiscount.create!(percentage: 40, threshold: 40, merchant_id: @merchant2.id)
  end

  it 'should be linked from the show page', :vcr do
    visit merchant_bulk_discount_path(@merchant1, @discount1)

    click_link 'Edit Discount'

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
  end

  it 'should be able to update dicount information', :vcr do
    visit merchant_bulk_discount_path(@merchant1, @discount1)

    click_link 'Edit Discount'

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))

    select "55", from: "Threshold"
    select "50", from: "Percentage"

    click_on 'Update Discount'

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))

    within '#information' do
      expect(page).to have_content('If a customer buys 55 units, they will receive a 50.0 percent discount.')
    end
  end
end
