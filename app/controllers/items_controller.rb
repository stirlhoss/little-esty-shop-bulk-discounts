class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if params[:status].present?
      redirect_to merchant_items_path(item.merchant_id)
    else
      redirect_to merchant_item_path(item.merchant_id, item.id)
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create(item_params)
    redirect_to merchant_items_path(@merchant.id)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
