Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :events, only: [:create, :index]
  end

  resources :events, only: [:index, :show, :update, :destroy]
end
