Rails.application.routes.draw do
  scope :api, module: :api, defaults: {format: :json} do
    resources :products, only: [:index, :create, :destroy, :show, :update]
  end
  root to: "api/products#index"
end
