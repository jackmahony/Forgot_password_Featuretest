Rails.application.routes.draw do
  get "/registration", to: "registrations#new", as: :sign_up
  post "/registration", to: "registrations#create", as: :registration
  delete "/sign_out", to: "sessions#destroy", as: :sign_out
  get "/sign_in", to: "sessions#new", as: :sign_in
  post "/sign_in", to: "sessions#create", as: :sign_in_create
  get "/reset_password", to: "passwords#edit", as: :reset_password
  post "/reset_password_email", to: "passwords#create", as: :reset_password_email
  get '/password_reset_confirmation', to: 'passwords#confirmation', as: :password_reset_confirmation
  get "/reset_password_confirm", to: "passwords#update", as: :reset_password_confirm
  root "site#index"
end
