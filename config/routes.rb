Rails.application.routes.draw do
  # root 'dashboards#index'

  resources :users, only: %i[new create show index]
  resources :sessions, only: %i[new create] do
    delete :destroy, on: :collection
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'rollbar/test' if Rails.env.development?

  scope module: 'web' do
    root 'bulletins#index'

    resources :bulletins, only: %i[index new create show]

    # # Остальные ресурсы в скоупе web
    # resource :auth, only: [] do
    #   get :callback
    # end
  end

  post 'auth/:provider', to: 'auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'web/auth#callback', as: :callback_auth
end
