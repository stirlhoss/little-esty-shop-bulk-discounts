class Admin::DashboardController < ApplicationController
  def index
    @customers_top_5 = Customer.top_customers
    @incomplete_invs = InvoiceItem.incomplete_inv
  end
end
