Rails.application.routes.draw do
  root 'schedules#index'
  resources :schedules, except: [:show]
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
