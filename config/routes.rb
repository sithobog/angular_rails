Rails.application.routes.draw do
  resources :products, only: [:index, :create, :destroy, :show, :update], defaults: {format: :json}
  root to: "products#index"
end
