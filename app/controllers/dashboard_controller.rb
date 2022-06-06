class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @repo = GithubFacade.git_repo
  end
end
