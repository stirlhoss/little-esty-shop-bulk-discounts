require 'rails_helper'

RSpec.describe MerchantBulkDiscounts: :Show do
  before :each do
    @merchant1 = Merchant.create!(name: 'Bobby Brown')
    @merchant2 = Merchant.create!(name: 'Steven Right')
    @discount1 = BulkDiscount.create!(percentage: 10, threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percentage: 20, threshold: 20, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percentage: 30, threshold: 30, merchant_id: @merchant1.id)
    @discount4 = BulkDiscount.create!(percentage: 40, threshold: 40, merchant_id: @merchant2.id)
  end

  it 'should have a link from the disocunts index page', :vcr do
    visit merchant_bulk_discounts_path(@merchant1)

    within "#discount-#{@discount1.id}" do
      click_link 'View Discount'
    end

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
  end

  it 'should display information on a specific discount', :vcr do
    visit merchant_bulk_discount_path(@merchant1, @discount1)

    within '#information' do
      expect(page).to have_content(@discount1.percentage)
      expect(page).to have_content(@discount1.threshold)
    end
  end
end
