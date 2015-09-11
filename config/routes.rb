Rails.application.routes.draw do
	scope :api, defaults: {format: :json} do
    resources :products, only: [:index, :create, :destroy, :show, :update]
  end
  root to: "products#index"
end
