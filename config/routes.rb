Rails.application.routes.draw do
  resources :products, only: [:index, :create, :destroy, :show], defaults: {format: :json}
  root to: "products#index"
end
