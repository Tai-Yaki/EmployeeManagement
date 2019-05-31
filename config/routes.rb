Rails.application.routes.draw do
  resources :employees

  root 'employees#index'
  get '/login', to: 'employees#login', as: 'login'
  post '/login', to: 'employees#login_user'
  get '/logout', to: 'employees#logout', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
