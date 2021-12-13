Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  devise_for :users,
            # path: '',
            # path_names: {
            #   sign_in: 'api/login',
            #   sign_out: 'api/logout',
            #   registration: 'api/signup'
            # },
             controllers: {
                 sessions: 'api/v1/sessions',
                 registrations: 'api/v1/registrations'
             }

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :planes, only: [:index, :show, :create, :destroy] do
        resources :reservations, only: [:index, :show, :create]
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
