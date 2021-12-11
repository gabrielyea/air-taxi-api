Rails.application.routes.draw do

devise_for :users,
             controllers: {
                 sessions: 'api/v1/sessions',
                 registrations: 'api/v1/registrations'
             }

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :users, only: [:index, :show, :create] do
        resources :planes, only: [:index, :show, :create] do
          resources :reservations, only: [:index, :show, :create]
        end
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
