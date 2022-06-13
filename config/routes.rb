Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    resources :bulk_discounts, controller: 'merchant_bulk_discounts',
              only: %i[index show new create]
    resources :items, only: %i[index show edit update new create]
    resources :dashboard, only: [:index]
    resources :invoices, only: %i[index show] do
      resources :invoice_items, only: %i[edit update]
    end
    # resources :invoice_items, only: %i[edit update]
  end

  namespace :admin do
    root to: 'dashboard#index', as: 'dashboard'
    resources :merchants, only: %i[index show edit update new create]
    resources :invoices, only: %i[index show edit update]
  end
end
