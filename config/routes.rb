Rails.application.routes.draw do

devise_for :users,
             controllers: {
                 sessions: 'api/v1/sessions',
                 registrations: 'api/v1/registrations'
             }
  # devise_for :users

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :users do
        resources :planes do
          resources :reservations
        end
      end
    end
    namespace :dev, defaults: {format: :json} do
      get 'fetch_test_planes', to: 'services#fech_planes'
      get 'fetch_test_reservations', to: 'services#fech_reservations'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
