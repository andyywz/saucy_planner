Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :events, only: [:create, :index]
  end

  resources :events, only: [:index, :show, :update, :destroy]

  get '/people/:person_id/events', to: 'events#index', as: 'person_events'

  post '/events/:event_id/people', to: 'people#create', as: 'register_attendee'

  resources :people, except: [:new, :edit, :create]

  get '/events/:event_id/people', to: 'people#index', as: 'event_attendees'
end
