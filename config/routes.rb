Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :articles
  # resources :patients do
  #   resources :appointments
  #   resources :admissions
  # end
  resources :patients
  namespace :departments do
    resources :appointments
    resources :admissions
  end
  resources :projects do
    resources :tasks
  end

  # Defines the root path route ("/")
  root "projects#index"
end
