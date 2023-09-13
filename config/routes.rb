Rails.application.routes.draw do
  namespace :api do
    resources :users
    post 'auth/login', to: 'auth#login'
    post 'auth/register' to: 'auth#register'
    get 'auth/revalidate-token', to: 'auth#revalidate'
  end
end
