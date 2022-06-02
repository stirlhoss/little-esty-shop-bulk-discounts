class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    merchant.save
    if merchant_params.include?(:status)
      redirect_to admin_merchants_path
    else
      redirect_to admin_merchant_path(merchant)
      flash[:alert] = 'Information Successfully Updated'
    end
  end

  def create
    Merchant.create!(name: params[:name])

    redirect_to admin_merchants_path
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :id, :status)
  end
end
