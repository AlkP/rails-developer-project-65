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

    resources :bulletins, only: %i[index show]

    namespace :admin do
      resources :bulletins, only: %i[index] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
      resources :categories
    end
  end

  resources :profile, only: %i[index new create edit update] do
    member do
      patch :to_moderate
      patch :archive
    end
  end

  resources :admin, only: [:index] do
    patch :archive, on: :member
  end

  post 'auth/:provider', to: 'auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'web/auth#callback', as: :callback_auth

  # дичь для тестов хекслета
  get 'profile/new_bulletin', to: 'profile#new', as: :new_bulletin
end
