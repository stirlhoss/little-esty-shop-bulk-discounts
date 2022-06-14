require 'rails_helper'

RSpec.describe MerchantBulkDiscounts: :Index do
  before :each do
    @merchant1 = Merchant.create!(name: 'Bobby Brown')
    @merchant2 = Merchant.create!(name: 'Steven Right')
    @discount1 = BulkDiscount.create!(percentage: 10, threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percentage: 20, threshold: 20, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percentage: 30, threshold: 30, merchant_id: @merchant1.id)
    @discount4 = BulkDiscount.create!(percentage: 40, threshold: 40, merchant_id: @merchant2.id)
  end

  it 'should be linked to from the merchants dashboard', :vcr do
    visit merchant_dashboard_index_path(@merchant1)

    click_on 'My Discounts'

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

    within "#discount-#{@discount1.id}" do
      expect(page).to have_content(@discount1.percentage)
      expect(page).to have_content(@discount1.threshold)
      expect(page).to have_link('View Discount')
    end
    within "#discount-#{@discount2.id}" do
      expect(page).to have_content(@discount2.percentage)
      expect(page).to have_content(@discount2.threshold)
      expect(page).to have_link('View Discount')
    end
    within "#discount-#{@discount3.id}" do
      expect(page).to have_content(@discount3.percentage)
      expect(page).to have_content(@discount3.threshold)
      expect(page).to have_link('View Discount')
    end

    expect(page).to_not have_content(@discount4.percentage)
    expect(page).to_not have_content(@discount4.threshold)
  end

  it 'should contain a link to the create a new discount', :vcr do
    visit merchant_bulk_discounts_path(@merchant1)

    click_link 'Create New Discount'

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))

    within '#threshold' do
      select(55)
    end
    within '#percentage' do
      select(20)
    end

    click_on 'Create'

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

    expect(page).to have_content 'Buy 55 units, get a 20.0% discount'
  end

  it 'should contatin a link to delete a discount', :vcr do
    visit merchant_bulk_discounts_path(@merchant1)

    expect(page).to have_content('Buy 10 units, get a 10.0% discount')

    within "#discount-#{@discount1.id}" do
      click_link 'Delete Discount'
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

    expect(page).to have_content('Buy 20 units, get a 20.0% discount')
    expect(page).to have_content('Buy 30 units, get a 30.0% discount')
    expect(page).to_not have_content('Buy 10 units, get a 10.0% discount')
  end

  it 'should show the next three holidays on the page', :vcr do
    visit merchant_bulk_discounts_path(@merchant1)

    @holidays = HolidayFacade.new

    expect(page).to have_content(@holidays.next_three_holidays[0].name)

    expect(page).to have_content(@holidays.next_three_holidays[0].date)

    expect(page).to have_content(@holidays.next_three_holidays[1].name)

    expect(page).to have_content(@holidays.next_three_holidays[1].date)

    expect(page).to have_content(@holidays.next_three_holidays[2].name)

    expect(page).to have_content(@holidays.next_three_holidays[2].date)
  end
end
