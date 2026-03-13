Rails.application.routes.draw do
  root 'dashboards#index'

  resources :users, only: %i[new create show index]
  resources :sessions, only: %i[new create] do
    delete :destroy, on: :collection
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'rollbar/test' if Rails.env.development?
end
